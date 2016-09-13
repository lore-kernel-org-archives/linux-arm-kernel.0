From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Sep 2016 20:55:08 +0100
Subject: [arm:sa1100 80/81] arch/arm/mach-pxa/mainstone.c:560: undefined
 reference to `gpio_reg_init'
In-Reply-To: <201609140228.hC8MtpFb%fengguang.wu@intel.com>
References: <201609140228.hC8MtpFb%fengguang.wu@intel.com>
Message-ID: <20160913195508.GZ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 02:12:30AM +0800, kbuild test robot wrote:
> tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
> head:   36b075e9681a293ef57aaa107ab394bc879a0807
> commit: 4c76c25bd4f755e2302807f99b75ff9954c036d1 [80/81] ARM: pxa/mainstone: convert PCMCIA to use MAX1600 driver and gpiod APIs
> config: arm-mainstone_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 4c76c25bd4f755e2302807f99b75ff9954c036d1
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm/mach-pxa/built-in.o: In function `mainstone_init':
> >> arch/arm/mach-pxa/mainstone.c:560: undefined reference to `gpio_reg_init'
>    arch/arm/mach-pxa/mainstone.c:563: undefined reference to `gpio_reg_init'

Thanks, fixed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
