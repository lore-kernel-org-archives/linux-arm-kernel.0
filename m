From: lkp@intel.com (kbuild test robot)
Date: Fri, 24 Jun 2016 09:21:45 +0800
Subject: [PATCH V2 2/4] STM Ftrace: Adding generic buffer interface driver
In-Reply-To: <1466563613-31578-3-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <201606240953.xWkmukcv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.7-rc4 next-20160623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/Integration-of-function-trace-with-System-Trace-IP-blocks/20160622-115305
config: m32r-allmodconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All errors (new ones prefixed by >>):

   ERROR: "bad_dma_ops" [sound/soc/fsl/snd-soc-fsl-asrc.ko] undefined!
   ERROR: "bad_dma_ops" [sound/soc/atmel/snd-soc-atmel-pcm-pdc.ko] undefined!
   ERROR: "bad_dma_ops" [sound/core/snd-pcm.ko] undefined!
   ERROR: "dma_common_mmap" [sound/core/snd-pcm.ko] undefined!
   ERROR: "__ucmpdi2" [lib/842/842_decompress.ko] undefined!
   ERROR: "__ucmpdi2" [fs/btrfs/btrfs.ko] undefined!
   ERROR: "__ucmpdi2" [drivers/media/i2c/adv7842.ko] undefined!
   ERROR: "__ucmpdi2" [drivers/md/bcache/bcache.ko] undefined!
   ERROR: "__ucmpdi2" [drivers/iio/imu/inv_mpu6050/inv-mpu6050.ko] undefined!
>> ERROR: "trace_rm_output" [drivers/hwtracing/stm/stm_ftrace.ko] undefined!
>> ERROR: "trace_add_output" [drivers/hwtracing/stm/stm_ftrace.ko] undefined!
   ERROR: "bad_dma_ops" [drivers/fpga/zynq-fpga.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35694 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160624/1e650c12/attachment-0001.obj>
