From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 17 Sep 2013 23:45:11 +0200 (CEST)
Subject: [RESEND PATCHv3 1/2] clocksource: dw_apb_timer: Move timer
 defines to header file.
In-Reply-To: <1379434447.24347.0.camel@linux-builds1>
References: <1377744796-22175-1-git-send-email-dinguyen@altera.com>
 <1379434447.24347.0.camel@linux-builds1>
Message-ID: <alpine.DEB.2.02.1309172337570.4089@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Sep 2013, Dinh Nguyen wrote:

> On Wed, 2013-08-28 at 21:53 -0500, Dinh Nguyen wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Move all dw_apb_timer defines to include/linux/dw_apb_timer.h.

That's describing WHAT the patch does not WHY. I can see the WHAT part
without that pointless changelog.

> 
> Ping? This patch series has sat idle for 2-weeks now.

So what?

Sending non urgent (i.e. bug fixes, regression fixes etc.) patches at
the beginning of the merge window begs for a 2 weeks delay. Well
documented procedure...


Thanks,

	tglx
