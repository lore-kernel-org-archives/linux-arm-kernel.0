From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Jul 2016 00:07:09 -0700
Subject: [RESEND PATCH v2 0/5] ir-rx51 driver fixes
In-Reply-To: <20160623044436.GK22406@atomide.com>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160623044436.GK22406@atomide.com>
Message-ID: <20160704070709.GT28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160622 21:47]:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160622 12:25]:
> > ir-rx51 is a driver for Nokia N900 IR transmitter. The current series
> > fixes the remaining problems in the driver:
> 
> Thanks for updating these.
> 
> Trierry, care to ack the PWM patch?
> 
> Mauro, do you want me to set up an immutable branch with all
> these against v4.7-rc1 that we can all merge as needed?
> 
> If you want to set up the branch instead, please feel free
> to add my ack.

OK so no comments from Mauro, so I've applied these with
Thierry's ack and pushed out into omap-for-v4.8/legacy branch.

Regards,

Tony
