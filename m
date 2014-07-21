From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 21 Jul 2014 15:06:48 +0800
Subject: [PATCH] ARM: i.MX6: add more chip revision support
In-Reply-To: <20140721063520.GR23235@pengutronix.de>
References: <1405921091-28748-1-git-send-email-shawn.guo@freescale.com>
 <20140721063520.GR23235@pengutronix.de>
Message-ID: <20140721070647.GK8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 08:35:20AM +0200, Sascha Hauer wrote:
> On Mon, Jul 21, 2014 at 01:38:11PM +0800, Shawn Guo wrote:
> > From: Jason Liu <r64343@freescale.com>
> > 
> > Add more revision support for the new i.MX6DQ tap-out (TO1.5).  This
> > TO1.5 is the Rev 1.3 as documented in i.MX6DQ data sheet, because TO1.3
> > and TO1.4 are never revealed.
> 
> So the chip identifies itself as 1.5 but the data sheet refers to it as
> 1.3. Is there a way to make that clear somewhere? Otherwise it's really
> confusing.

I can add a note about that in the code, but I'm not really sure if
there is a better way to pass such info to end users.  Suggestions are
welcomed.

Shawn
