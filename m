From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 16 Jul 2012 09:03:28 +0200
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20120715150003.GD2429@S2100-06.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
 <20120715144935.GB2429@S2100-06.ap.freescale.net>
 <20120715150003.GD2429@S2100-06.ap.freescale.net>
Message-ID: <20483.48320.888197.282702@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Sun, Jul 15, 2012 at 10:49:35PM +0800, Shawn Guo wrote:
> > below.  But does that mean ethernet PHY does not work even on non-DT
> > kernel right now?
> > 
> So I guess you need something like c46d291 (ARM: apx4devkit: fix FEC
> enabling PHY clock) for TX28 too.
> 
That's already in place.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
