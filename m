From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Jun 2011 14:02:58 +0200
Subject: Git pull request: 64-bit atomic user helper
In-Reply-To: <20110630100755.GU21898@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1106202134510.2142@xanadu.home>
	<20110630100755.GU21898@n2100.arm.linux.org.uk>
Message-ID: <20110630120258.GI11559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jun 30, 2011 at 11:07:55AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 20, 2011 at 09:54:07PM -0400, Nicolas Pitre wrote:
> > Russell, please pull the following for the next merge window:
> > 
> > 	git://git.linaro.org/people/nico/linux.git cmpxchg64
> > 
> As these clash with the entry rework which I have, I'd much prefer
> them to be in patch form rather than git form so I don't have to keep
> remembering to fix the (broken) git rerere merge.  git rerere is fine
> if you get it right first time but if not, then it keeps doing it wrong
> each and every time.
	git rerere forget <pathspec>
might be what you are looking for.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
