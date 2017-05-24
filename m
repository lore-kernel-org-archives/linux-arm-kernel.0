From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 24 May 2017 19:20:48 +0800
Subject: [nomadik:gemini-dir-685-tvc 24/24] htmldocs:
 drivers/gpu/drm/tve200/tve200_drv.c:1: warning: no structured comments found
Message-ID: <201705241946.MQH945TG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-tvc
head:   b09e3156ca92c226eda407c70377a5dae458d889
commit: b09e3156ca92c226eda407c70377a5dae458d889 [24/24] stab
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   arch/x86/include/asm/uaccess_32.h:1: warning: no structured comments found
   include/linux/init.h:1: warning: no structured comments found
   include/linux/mod_devicetable.h:686: warning: Excess struct/union/enum/typedef member 'ver_major' description in 'fsl_mc_device_id'
   include/linux/mod_devicetable.h:686: warning: Excess struct/union/enum/typedef member 'ver_minor' description in 'fsl_mc_device_id'
   kernel/sched/core.c:2088: warning: No description found for parameter 'rf'
   kernel/sched/core.c:2088: warning: Excess function parameter 'cookie' description in 'try_to_wake_up_local'
   include/linux/kthread.h:26: warning: Excess function parameter '...' description in 'kthread_create'
   kernel/sys.c:1: warning: no structured comments found
   include/linux/device.h:969: warning: No description found for parameter 'dma_ops'
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/linux/iio/iio.h:597: warning: No description found for parameter 'trig_readonly'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'indio_dev'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'trig'
   include/linux/device.h:970: warning: No description found for parameter 'dma_ops'
   include/linux/usb/gadget.h:230: warning: No description found for parameter 'claimed'
   include/linux/usb/gadget.h:230: warning: No description found for parameter 'enabled'
   include/linux/usb/gadget.h:408: warning: No description found for parameter 'quirk_altset_not_supp'
   include/linux/usb/gadget.h:408: warning: No description found for parameter 'quirk_stall_not_supp'
   include/linux/usb/gadget.h:408: warning: No description found for parameter 'quirk_zlp_not_supp'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'set_busid'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'irq_handler'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'irq_preinstall'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'irq_postinstall'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'irq_uninstall'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'debugfs_init'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_open_object'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_close_object'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'prime_handle_to_fd'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'prime_fd_to_handle'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_export'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_import'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_vm_ops'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'major'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'minor'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'patchlevel'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'name'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'desc'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'date'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'driver_features'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'ioctls'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'num_ioctls'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'fops'
   include/drm/drm_color_mgmt.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_plane_helper.c:403: warning: No description found for parameter 'ctx'
   drivers/gpu/drm/drm_plane_helper.c:404: warning: No description found for parameter 'ctx'
   drivers/gpu/drm/i915/intel_lpe_audio.c:350: warning: No description found for parameter 'dp_output'
   drivers/gpu/drm/i915/intel_lpe_audio.c:350: warning: No description found for parameter 'link_rate'
   drivers/gpu/drm/i915/intel_lpe_audio.c:351: warning: No description found for parameter 'dp_output'
   drivers/gpu/drm/i915/intel_lpe_audio.c:351: warning: No description found for parameter 'link_rate'
>> drivers/gpu/drm/tve200/tve200_drv.c:1: warning: no structured comments found
   Documentation/core-api/assoc_array.rst:13: WARNING: Enumerated list ends without a blank line; unexpected unindent.
   Documentation/doc-guide/sphinx.rst:126: ERROR: Unknown target name: "sphinx c domain".
   kernel/sched/fair.c:7650: WARNING: Inline emphasis start-string without end-string.
   kernel/time/timer.c:1200: ERROR: Unexpected indentation.
   kernel/time/timer.c:1202: ERROR: Unexpected indentation.
   kernel/time/timer.c:1203: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:122: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:125: ERROR: Unexpected indentation.
   include/linux/wait.h:127: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:990: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:322: WARNING: Inline literal start-string without end-string.
   include/linux/iio/iio.h:219: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:220: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:226: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/iio/industrialio-core.c:638: ERROR: Unknown target name: "iio_val".
   drivers/iio/industrialio-core.c:645: ERROR: Unknown target name: "iio_val".
   drivers/message/fusion/mptbase.c:5051: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1898: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/pci/pci.c:3456: ERROR: Unexpected indentation.
   include/linux/regulator/driver.h:271: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   include/linux/spi/spi.h:370: ERROR: Unexpected indentation.
   drivers/gpu/drm/drm_scdc_helper.c:203: ERROR: Unexpected indentation.
   drivers/gpu/drm/drm_scdc_helper.c:204: WARNING: Block quote ends without a blank line; unexpected unindent.
   drivers/gpu/drm/drm_ioctl.c:690: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/gpu/todo.rst:111: ERROR: Unknown target name: "drm_fb".
   sound/soc/soc-core.c:2670: ERROR: Unknown target name: "snd_soc_daifmt".
   sound/core/jack.c:312: ERROR: Unknown target name: "snd_jack_btn".
   Documentation/usb/typec.rst:116: ERROR: Error in "kernel-doc" directive:
   invalid option block.

vim +1 drivers/gpu/drm/tve200/tve200_drv.c

   > 1	/*
     2	 * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
     3	 * Parts of this file were based on sources as follows:
     4	 *
     5	 * Copyright (C) 2006-2008 Intel Corporation
     6	 * Copyright (C) 2007 Amos Lee <amos_lee@storlinksemi.com>
     7	 * Copyright (C) 2007 Dave Airlie <airlied@linux.ie>
     8	 * Copyright (C) 2011 Texas Instruments
     9	 * Copyright (C) 2017 Eric Anholt

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6639 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170524/37d2da70/attachment-0001.gz>
