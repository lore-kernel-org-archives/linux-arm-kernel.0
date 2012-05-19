From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 19 May 2012 18:02:56 +0200
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <20120519123423.GA5676@S2100-06.ap.freescale.net>
References: <4FB583CF.2080801@grid-net.com>
 <201205190323.18058.marek.vasut@gmail.com>
 <20120519123423.GA5676@S2100-06.ap.freescale.net>
Message-ID: <201205191802.56342.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sat, May 19, 2012 at 03:23:17AM +0200, Marek Vasut wrote:
> > Hm actually ... does anyone have dts file for mx28 with enabled GPMI
> > nand? Looks like that thing from example doesn't work (had to replace
> > gpmi-nand with gpmi), then it stopped complaining about clock.
> > But now it dies on ecc.strength not
> > being set.
> 
> Huang Shijie (Cc-ed) might be interested in knowing and fixing those,
> but probably during v3.5-rc.
> 
> > MMC doesn't probe either etc.
> 
> Are you using next-20120516 or later?

yes

Best regards,
Marek Vasut
