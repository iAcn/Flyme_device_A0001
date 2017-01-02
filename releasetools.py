import common
import edify_generator

def modifyBegin(edify):
	edify.script[0] = \
  '''ifelse(is_mounted("/system"), unmount("/system"));
ui_print("******************************************");
ui_print("* Flyme for OnePlus One");
ui_print("*");
ui_print("* Romer: iAcn");
ui_print("* http://weibo.com/SkyTrous");
ui_print("******************************************");\n''' + edify.script[0]

def modifyMount(edify):
	for i in xrange(len(edify.script)):
		if "mount(" in edify.script[i] and "by-name/system" in edify.script[i]:
			edify.script[i] = 'mount("ext4", "EMMC", "/dev/block/platform/msm_sdcc.1/by-name/system", "/system");'

def modifyCommand(edify):
	for i in xrange(len(edify.script)):
		if "package_extract_dir(" in edify.script[i] and "recovery" in edify.script[i]:
			edify.script[i] = 'ui_print("{*} Extracting System");'
		elif "install-recovery" in edify.script[i]:
			edify.script[i] = ''

def addPrompt(edify):
	for i in xrange(len(edify.script)):
		if "format(" in edify.script[i] and "by-name/system" in edify.script[i]:
			edify.script[i] = 'ui_print("{*} Formatting System");\n' + edify.script[i]
		elif 'set_metadata_recursive("/system"' in edify.script[i]:
			edify.script[i] = 'ui_print("{*} Setting Permissions");\n' + edify.script[i]
		elif 'package_extract_file("boot' in edify.script[i]:
			edify.script[i] = 'ui_print("{*} Flashing Kernel");\n' + edify.script[i]

def addSuperSU(info):
	SuperSU = info.input_zip.read("META/SuperSU.zip")
	common.ZipWriteStr(info.output_zip, "SuperSU/SuperSU.zip", SuperSU)
	
	edify = info.script
	
	edify.AppendExtra(('ui_print("{*} Flashing SuperSU");'))
	edify.AppendExtra(('package_extract_dir("SuperSU", "/tmp/supersu");'))
	edify.AppendExtra(('run_program("/sbin/busybox", "unzip", "/tmp/supersu/SuperSU.zip", "META-INF/com/google/android/*", "-d", "/tmp/supersu");'))
	edify.AppendExtra(('run_program("/sbin/busybox", "sh", "/tmp/supersu/META-INF/com/google/android/update-binary", "dummy", "1", "/tmp/supersu/SuperSU.zip");'))
	edify.AppendExtra(('mount("ext4", "EMMC", "/dev/block/platform/msm_sdcc.1/by-name/system", "/system");'))
	edify.AppendExtra(('ui_print("{*} Finish!");'))

def FullOTA_InstallEnd(info):
	edify = info.script

	modifyBegin(edify)
	modifyMount(edify)
	modifyCommand(edify)
	addPrompt(edify)
	addSuperSU(info)

def IncrementalOTA_InstallEnd(info):
	modifyMount(info.script)
