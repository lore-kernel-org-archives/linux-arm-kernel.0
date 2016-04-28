From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Apr 2016 14:27:49 -0700
Subject: [PATCH 0/2] Fix ir-rx51 by using PWM pdata
In-Reply-To: <57227E63.4040907@gmail.com>
References: <1461714709-10455-1-git-send-email-tony@atomide.com>
 <57227E63.4040907@gmail.com>
Message-ID: <20160428212748.GI5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160428 14:21]:
> 
> I didn't test legacy boot, as I don't really see any value of doing it now
> the end of the legacy boot is near, the driver does not function correctly,
> however the patchset at least allows for the driver to be build and we have
> something to improve on. And I am going to send a patch that fixes the
> problem with omap_dm_timer_request_specific(). So, for both patches, you may
> add:
> 
> Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

OK thanks.

Mauro, do the driver changes look OK to you?

If so, I could queue the driver too for v4.7 because of the
dependency with your ack. Or I can provide you an immutable
branch with just the pdata changes against v4.6-rc1 if you
prefer that.

Regards,

Tony
