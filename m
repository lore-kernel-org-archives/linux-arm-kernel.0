From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Oct 2017 10:06:42 +0100
Subject: [arm:for-next 9/11] awk: line 2: function strtonum never defined
In-Reply-To: <201710030905.zGRrw4dZ%fengguang.wu@intel.com>
References: <201710030905.zGRrw4dZ%fengguang.wu@intel.com>
Message-ID: <20171003090642.GJ20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shall I repeat my question from the last time this was reported?

On Tue, Oct 03, 2017 at 09:52:08AM +0800, kbuild test robot wrote:
> Hi Russell,
> 
> FYI, the error/warning still remains.
> 
> tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
> head:   3cef8ede5ead55fbaf2225206f00361828adc3a1
> commit: 887518f5e9963a82c3fc2ad8911eedb2304f8c57 [9/11] ARM: decompressor: fix BSS size calculation
> config: arm-clps711x_defconfig (attached as .config)
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
> --
> >> awk: line 2: function strtonum never defined
> >> awk: line 2: function strtonum never defined
>    arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux': No such file
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
