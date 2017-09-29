From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Sep 2017 20:06:25 +0100
Subject: [arm:for-next 9/10] awk: line 2: function strtonum never defined
In-Reply-To: <201709300322.kIz06Tci%fengguang.wu@intel.com>
References: <201709300322.kIz06Tci%fengguang.wu@intel.com>
Message-ID: <20170929190624.GD20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Which awk are you using?

On Sat, Sep 30, 2017 at 03:05:25AM +0800, kbuild test robot wrote:
> tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
> head:   23b907cf143ec004c227fa2649c64d8e53f7fd2f
> commit: 887518f5e9963a82c3fc2ad8911eedb2304f8c57 [9/10] ARM: decompressor: fix BSS size calculation
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 887518f5e9963a82c3fc2ad8911eedb2304f8c57
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> awk: line 2: function strtonum never defined
> >> awk: line 2: function strtonum never defined
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
