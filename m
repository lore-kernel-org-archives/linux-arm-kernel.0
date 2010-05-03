From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 May 2010 20:43:34 +0200
Subject: [PATCH] arm: Fix .gitignore for boot/compressed folder
In-Reply-To: <A24693684029E5489D1D202277BE8944551B8F75@dlee02.ent.ti.com>
References: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
	<20100502122049.GA5553@pengutronix.de>
	<A24693684029E5489D1D202277BE8944551B8F75@dlee02.ent.ti.com>
Message-ID: <20100503184334.GA24866@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 03, 2010 at 10:24:07AM -0500, Aguirre, Sergio wrote:
> 
> 
> From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> Sent: Sunday, May 02, 2010 7:21 AM
> > On Thu, Feb 25, 2010 at 09:55:45AM -0600, Sergio Aguirre wrote:
> > > This should complements changes done in:
> > I think this should read "complement" only, that is, no 's' at the end.
> > Other than that,
> 
> Oops, typo fixed. Thanks for noticing that!
No problem.

> Also... I added arch/arm/boot/compressed/vmlinux to the list, since when I
> build for my OMAP3 board, it shows in the dirty index.
> 
> Is it acceptable to add that aswell? If yes, then attached patch contains
> your ACK + vmlinux added to the list.
This is OK, but IMHO you should note it in the commit log.  (And I think
most people prefer inline patches over attached ones.)

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
