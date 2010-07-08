From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 8 Jul 2010 21:22:30 +0200
Subject: linux 2.6.34 bug
In-Reply-To: <201007081842.16347.marek.vasut@gmail.com>
References: <20100708173621.00003527@unknown>
	<201007081842.16347.marek.vasut@gmail.com>
Message-ID: <20100708192230.GA27952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jul 08, 2010 at 06:42:16PM +0200, Marek Vasut wrote:
> Dne ?t 8. ?ervence 2010 17:36:21 dylan cristiani napsal(a):
> > Hi Marek,
> > we were in touch few moths ago about a ucb1400 touchscreen, issue if you
> > remember: you sent me a patch to pass the platform specific codec irq,
> > through ucb1400_pdata; after that i went from 3.6.32 to 2.6.34 and
> > i noticed that your patch was into mainline; in this kernel, related to
> > the ucb1400 codec again, i noticed one bug about the ac97 codec reset
> > that is bulverde platform specific: i don't know hot to submit a patch
> > and to whom to submit it, so i bother, you sorry in advance....; in
> > particular: in new kernel the function
> > "void pxa27x_assert_ac97reset(int reset_gpio, int on)"
> > has been moved to arch/arm/mach-pxa/pxa27x.c file:
> 
> CCing linux-arm-kernel and Eric.
> 
> btw. to submit patch :
> 
> git add <list of changed files>
> 
> git commit -s
> <editor will pop up, type the commit message>
> 
> git log # here check the hash of the last commit before yours
> 
> git send-email --to="linux-arm-kernel at lists.infradead.org" --
> cc="eric.y.miao at gmail.com" --cc="marek.vasut at gmail.com" <the hash from previous 
> step>
> 
> That's probably the easiest way :)
No.  Instead of checking the hash of the last commit via git log, you
can simply pass "HEAD~1" instead of the actual hash.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
