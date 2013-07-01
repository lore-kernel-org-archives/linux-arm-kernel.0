From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Jul 2013 02:15:38 +0000 (UTC)
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com>
 <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com>
 <51CBBCD8.5030600@ti.com>
 <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1307010211580.3741@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jun 2013, Paul Walmsley wrote:

> On Thu, 27 Jun 2013, Lokesh Vutla wrote:
>
> > Here is the catch..
> > Your dtb is generated in arch/arm/boot/dts/ folder(before V3.8 dtb was
> > generated in arch/arm/boot).
> 
> Ugh... that's probably it :-(

Indeed, this was at least one major problem.  With this fixed, and with 
CONFIG_MACH_OMAP_GENERIC=y in the v3.10-rc Kconfigs, the BeagleBone white 
boots here now with v3.10-rc7.  Will test the previous releases going back 
to v3.8 and will update the web-linked READMEs as appropriate.

Thanks for the help and the fixes.  Vaibhav and Rajendra, thanks also for 
looking into it.


- Paul
