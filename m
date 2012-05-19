From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 19 May 2012 20:34:24 +0800
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <201205190323.18058.marek.vasut@gmail.com>
References: <4FB583CF.2080801@grid-net.com>
 <20120518010138.GA5427@S2101-09.ap.freescale.net>
 <4FB6D2A2.1090400@grid-net.com>
 <201205190323.18058.marek.vasut@gmail.com>
Message-ID: <20120519123423.GA5676@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2012 at 03:23:17AM +0200, Marek Vasut wrote:
> Hm actually ... does anyone have dts file for mx28 with enabled GPMI nand? Looks 
> like that thing from example doesn't work (had to replace gpmi-nand with gpmi), 
> then it stopped complaining about clock.
> But now it dies on ecc.strength not 
> being set.

Huang Shijie (Cc-ed) might be interested in knowing and fixing those,
but probably during v3.5-rc.

> MMC doesn't probe either etc.
> 
Are you using next-20120516 or later?

-- 
Regards,
Shawn
