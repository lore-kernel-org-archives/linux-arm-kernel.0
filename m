From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 29 Nov 2010 20:35:44 +0100
Subject: [PATCH 28/51] ARM: mx25: dynamically allocate mxc-ehci devices
In-Reply-To: <20101129145139.GH4233@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
	<1290029419-21435-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<4CEFCC9A.2020500@fqingenieria.es>
	<20101126194831.GA25293@pengutronix.de>
	<AANLkTik53KX4Ni3Vd7MNpXnxp_c6U=CD_tzJ+7ycEsQ5@mail.gmail.com>
	<20101129145139.GH4233@pengutronix.de>
Message-ID: <20101129193544.GD4233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 03:51:39PM +0100, Robert Schwebel wrote:
> On Mon, Nov 29, 2010 at 10:48:47AM +0800, Shawn Guo wrote:
> > I confirmed it with i.MX25 design team that offset 0x400 is the
> > correct one, and 0x200 will not work. I will ping documentation team
> > to get this document error fixed.
>
> You have a documentation team that fixes *documentation errors*? Wow, I
> didn't think so :-) Let's see what else we have around ...

Sorry, this wasn't serious. But it's good to know that somebody is
caring about the documentation - we have seen many, many cut-and-paste
bugs in different processor manuals so far and didn't find a good way to
provide you with that feedback.

Best regards,
Robert
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
