From: lkp@intel.com (kbuild test robot)
Date: Thu, 7 Jul 2016 12:43:51 +0800
Subject: [PATCH v6 01/18] remoteproc: st_slim_rproc: add a slimcore rproc
 driver
In-Reply-To: <1467795276-21725-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <201607071253.LjDLXvzg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc6 next-20160706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Griffin/Add-support-for-FDMA-DMA-controller-and-slim-core-rproc-found-on-STi-chipsets/20160706-170304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
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
>> ERROR: "vring_del_virtqueue" [drivers/remoteproc/remoteproc.ko] undefined!
>> ERROR: "register_virtio_device" [drivers/remoteproc/remoteproc.ko] undefined!
>> ERROR: "bad_dma_ops" [drivers/remoteproc/remoteproc.ko] undefined!
>> ERROR: "unregister_virtio_device" [drivers/remoteproc/remoteproc.ko] undefined!
>> ERROR: "vring_new_virtqueue" [drivers/remoteproc/remoteproc.ko] undefined!
>> ERROR: "vring_interrupt" [drivers/remoteproc/remoteproc.ko] undefined!
>> ERROR: "vring_transport_features" [drivers/remoteproc/remoteproc.ko] undefined!
   ERROR: "__ucmpdi2" [drivers/media/i2c/adv7842.ko] undefined!
   ERROR: "__ucmpdi2" [drivers/md/bcache/bcache.ko] undefined!
   ERROR: "__ucmpdi2" [drivers/iio/imu/inv_mpu6050/inv-mpu6050.ko] undefined!
   ERROR: "bad_dma_ops" [drivers/fpga/zynq-fpga.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35701 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160707/c3eb49d1/attachment-0001.obj>
