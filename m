From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Jun 2015 11:06:58 -0700
Subject: [PATCH] ARM: dts: AM35xx: fix system control module clocks
In-Reply-To: <20150601180429.GA30984@atomide.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
 <556C8ED5.5050000@myspectrum.nl>
 <20150601173126.GY30984@atomide.com>
 <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
 <20150601180429.GA30984@atomide.com>
Message-ID: <20150601180658.GB30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150601 11:06]:
> * Paul Walmsley <paul@pwsan.com> [150601 10:45]:
> > 
> > See for example the "Build warnings from toolchain", "Kernel warnings 
> > during boot to userspace", "Kernel warnings during PM test", and "Obsolete 
> > Kconfig symbols" sections here:
> > 
> > http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/README.txt
> 
> OK somehow 3517evm is listed under "skip" there? 

Oh I see you have two 3517 devices there, never mind.

Hmm now I'm wondering what the panda es warnings listed there are..

Tony
