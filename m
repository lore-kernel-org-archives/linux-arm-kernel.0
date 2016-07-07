From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 7 Jul 2016 11:20:29 +0100
Subject: [PATCH v6 18/18] remoteproc: core: Retry
 rproc_fw_config_virtio() if !rproc->table_ptr
In-Reply-To: <201607070935.iuu6KqiK%fengguang.wu@intel.com>
References: <1467795276-21725-19-git-send-email-peter.griffin@linaro.org>
 <201607070935.iuu6KqiK%fengguang.wu@intel.com>
Message-ID: <20160707102029.GA8755@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 07 Jul 2016, kbuild test robot wrote:

> Hi,
> 
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on v4.7-rc6 next-20160706]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Griffin/Add-support-for-FDMA-DMA-controller-and-slim-core-rproc-found-on-STi-chipsets/20160706-170304
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: openrisc-allyesconfig (attached as .config)
> compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=openrisc 
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/remoteproc/remoteproc_internal.h:52:13: warning: 'rproc_fw_config_virtio_cb' declared 'static' but never defined
> >> drivers/remoteproc/remoteproc_internal.h:53:13: warning:
> >> 'rproc_fw_config_virtio' declared 'static' but never defined

Will fix this in next version.

regards,

Peter.
