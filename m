From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Dec 2013 07:26:54 -0800
Subject: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
In-Reply-To: <alpine.DEB.2.02.1312170707140.14039@utopia.booyaka.com>
References: <pull-1386643347-596413>
 <alpine.DEB.2.02.1312101034360.32309@utopia.booyaka.com>
 <20131210185902.GO13171@atomide.com>
 <20131210192726.GR13171@atomide.com>
 <20131210230722.GZ13171@atomide.com>
 <20131213192622.GI28184@atomide.com>
 <alpine.DEB.2.02.1312170707140.14039@utopia.booyaka.com>
Message-ID: <20131217152653.GM12324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [131216 23:16]:
> On Fri, 13 Dec 2013, Tony Lindgren wrote:
> 
> > OK posted a patch for the SBC-T3730 with minimal support also for
> > SBC-3530 and SBC-3517 that should boot far enough to start adding
> > more devices. Paul, care to try it on the CM-T3517, the patch is:
> > 
> > [PATCH] ARM: dts: Add support for sbc-3xxx with cm-t3730
> 
> Didn't get anything out of the serial port:
> 
> http://www.pwsan.com/omap/testlogs/test_tonys_conversion_v3.14/20131215235827/boot/cmt3517/cmt3517_log.txt

OK thanks for testing. Looks like the CompuLab guys will need to
take a look at it. I'll update my patch for SBC-T3730 only with the
comments from Igor.
 
> As a partial sanity check, AM3517 EVM was included as part of the run 
> (with a separate uImage+dtb of course) and that seems to boot OK:
> 
> http://www.pwsan.com/omap/testlogs/test_tonys_conversion_v3.14/20131215235827/boot/3517evm/3517evm_log.txt

Hmm OK, weird that the 3517 EVM boots but not the CM-T3517.
 
> In case it's useful, here's a CM-T3517 boot log from v3.13-rc4:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.13-rc4/20131215195251/boot/cmt3517/cmt3517_log.txt

OK thanks.

Tony
