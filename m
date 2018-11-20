From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 20 Nov 2018 16:42:17 +0100
Subject: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
In-Reply-To: <20181119195528.elyioqz36be3ews3@pengutronix.de>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
 <20181116100500.GC28631@ulmo>
 <20181119195528.elyioqz36be3ews3@pengutronix.de>
Message-ID: <20181120154217.GC28796@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 08:55:28PM +0100, Uwe Kleine-K?nig wrote:
> Hello Thierry,
> 
> On Fri, Nov 16, 2018 at 11:05:00AM +0100, Thierry Reding wrote:
> > Applied, with some minor fixes to the commit message (pwm -> PWM,
> > pwm_release -> pwm_put(), ...).
> 
> Thanks. I wonder though why the commit didn't make it into next yet.
> Your for-next branch doesn't contain anything that's not already in
> Linus Torvalds' tree. I assume this isn't on purpose and you just didn't
> push your changes out?

Pushed now.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/68f35216/attachment.sig>
