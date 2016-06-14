From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Tue, 14 Jun 2016 17:02:24 +0300
Subject: [PATCH v2 4/4] ARM: dts: sun7i: Add NFC node to Allwinner A20 SoC
In-Reply-To: <20160614135716.GK9354@lukather>
References: <1465903058-9211-5-git-send-email-mamlinav@gmail.com>
 <201606142105.1AaT2uM6%fengguang.wu@intel.com>
 <20160614161908.53016f4f22c18e9126a041d2@gmail.com>
 <20160614135716.GK9354@lukather>
Message-ID: <20160614170224.2cfc3545b8b5b4b5935547a6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Jun 2016 15:57:16 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Tue, Jun 14, 2016 at 04:19:08PM +0300, Aleksei Mamlin wrote:
> > On Tue, 14 Jun 2016 21:11:12 +0800
> > kbuild test robot <lkp@intel.com> wrote:
> > 
> > > Hi,
> > > 
> > > [auto build test ERROR on mripard/sunxi/for-next]
> > > [also build test ERROR on next-20160614]
> > > [cannot apply to robh/for-next v4.7-rc3]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Aleksei-Mamlin/dts-sunxi-Add-sunxi-NAND-Flash-Controller-support/20160614-192539
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi/for-next
> > > config: arm-sunxi_defconfig (attached as .config)
> > > compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> > > reproduce:
> > >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         make.cross ARCH=arm 
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> Error: arch/arm/boot/dts/sun7i-a20.dtsi:806.26-27 syntax error
> > >    FATAL ERROR: Unable to parse input tree
> > > 
> > 
> > My bad, dual semicolon at line 806. Maxime, can you fix it locally?
> 
> Already did :)

Thanks a lot!

> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com


-- 
Thanks and regards,
Aleksei Mamlin
