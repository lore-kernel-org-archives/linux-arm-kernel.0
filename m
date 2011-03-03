From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Mar 2011 12:49:49 +0100
Subject: [PATCHv1] ARM: imx: Add support for low power suspend on MX51.
In-Reply-To: <alpine.LFD.2.00.1103031140330.2701@localhost6.localdomain6>
References: <1299086278-12131-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20110302215238.GK22310@pengutronix.de>
	<alpine.LFD.2.00.1103022343410.2701@localhost6.localdomain6>
	<20110303093532.GO22310@pengutronix.de>
	<alpine.LFD.2.00.1103031140330.2701@localhost6.localdomain6>
Message-ID: <20110303114949.GQ22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Thu, Mar 03, 2011 at 12:02:15PM +0100, Thomas Gleixner wrote:
> On Thu, 3 Mar 2011, Uwe Kleine-K?nig wrote:
> > On Thu, Mar 03, 2011 at 12:51:32AM +0100, Thomas Gleixner wrote:
> > > > > +static int __init mx5_pm_init(void)
> > > > I'd prefer to have that called by imx51_init_early.
> > > 
> > > And the reason is? 
> > > 
> > >     1) your personal preference
> > >     2) there is some useful technical reason
> > > 
> > > If #1, then this comment was just waste of electrons
> > > If #2, you failed to provide some reasonable explanation
> > Actually it's #2, and to quote a different review[1]:
> > 
> > 	Reviewers hint to a correct solution and you are supposed to
> > 	lookup what that solution means and act accordingly. If you do
> > 	not understand the hint or its implications please ask [...]
> 
> I said the above when I hinted to use DEFINE_SPINLOCK(lock) instead of
> static spinlock_t lock. And that requires to lookup what
> DEFINE_SPINLOCK() actually does, which is a reasonable request.
> 
> How is the author of that code supposed to figure out what the merit
> of s/mx5_pm_init/imx51_init_early/ is? By looking up your preferences
> in google or what?
Note I didn't suggest to change the function name.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
