From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 9 Jan 2012 08:05:14 +0100
Subject: mxs: enable phy-clock in the driver?
In-Reply-To: <20120109065845.GL1835@S2101-09.ap.freescale.net>
References: <20120108144558.GB2544@pengutronix.de>
 <20120109013404.GD1835@S2101-09.ap.freescale.net>
 <20234.35823.411762.856482@ipc1.ka-ro>
 <20120109065845.GL1835@S2101-09.ap.freescale.net>
Message-ID: <20234.37290.114047.36369@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Mon, Jan 09, 2012 at 07:40:47AM +0100, Lothar Wa?mann wrote:
> > The TX28 derives its PHY clock from the ENET_CLK pin of the
> > processor. Thus the CLK_ENET_TIME should be enabled by the driver as
> > mentioned in <20120108033238.GA19721@S2101-09.ap.freescale.net>
> > 
> Can you give a web link for that message?
> 
It's your own email from "Sun, 8 Jan 2012 11:32:40 +0800" with the
subject "Re: MX28 fec clock frequency":
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/079556.html


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
