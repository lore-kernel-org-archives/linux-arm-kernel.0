From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 17 Aug 2016 22:40:09 +0800
Subject: [shawnguo:imx/dt 15/22] ERROR: Input tree has errors, aborting
 (use -f to force output)
In-Reply-To: <201608170226.eMaKynUU%fengguang.wu@intel.com>
References: <201608170226.eMaKynUU%fengguang.wu@intel.com>
Message-ID: <20160817144009.GA17200@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 02:08:42AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/dt
> head:   aa4eab4468913b80fbed464abf1b94d64f0bb7cc
> commit: 7f876822566dc2dd9fde51940941676651eacaef [15/22] ARM: dts: imx7s: Add SAI nodes
> config: arm-multi_v7_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 7f876822566dc2dd9fde51940941676651eacaef
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> Note: the shawnguo/imx/dt HEAD aa4eab4468913b80fbed464abf1b94d64f0bb7cc builds fine.
>       It only hurts bisectibility.

Fixed, thanks.
