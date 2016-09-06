From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 23:22:45 +0100
Subject: [arm:sa1100 33/97] arch/arm/common/sa1111.c:515:19: error:
 'irqbase' undeclared
In-Reply-To: <201609070356.QKsjqKNj%fengguang.wu@intel.com>
References: <201609070356.QKsjqKNj%fengguang.wu@intel.com>
Message-ID: <20160906222245.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 03:29:58AM +0800, kbuild test robot wrote:
> tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git sa1100

Please use git://git.armlinux.org.uk/~rmk/linux-arm.git instead -
the new machine is in place and should be able to cope just fine with
whatever git load, so there should be no need to use mirrors anymore.
I think you're using that already for some reports anyway.

> head:   8712f29f4497fc83173d512149d3949b6f87e2dd
> commit: 31dbff2701e82c42bb210a7e310abe63c0a96c66 [33/97] ARM: sa1111: move irq cleanup to separate function
> config: arm-sa1100 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 31dbff2701e82c42bb210a7e310abe63c0a96c66
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 

ETOOMANYPATCHES. :p

Thanks, should be fixed now.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
