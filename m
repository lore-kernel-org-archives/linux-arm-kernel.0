From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 07 Oct 2010 10:37:03 -0700
Subject: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime
	api's
In-Reply-To: <20100928233334.GS21564@trinity.fluff.org> (Ben Dooks's message
	of "Wed, 29 Sep 2010 00:33:34 +0100")
References: <1285078036-12789-1-git-send-email-rnayak@ti.com>
	<1285078036-12789-2-git-send-email-rnayak@ti.com>
	<1285078036-12789-3-git-send-email-rnayak@ti.com>
	<1285078036-12789-4-git-send-email-rnayak@ti.com>
	<1285078036-12789-5-git-send-email-rnayak@ti.com>
	<1285078036-12789-6-git-send-email-rnayak@ti.com>
	<20100927223645.GJ21564@trinity.fluff.org>
	<0680EC522D0CC943BC586913CF3768C003FF05981F@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C003FF05988F@dbde02.ent.ti.com>
	<20100928233334.GS21564@trinity.fluff.org>
Message-ID: <87vd5d9a68.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks <ben-i2c@fluff.org> writes:

[...]

> As such, I should really go and read up all about this new runtime-pm
> and hwmod stuff before further commentign on the changes.

ping


>From bogus@does.not.exist.com  Wed Oct  6 18:52:23 2010
From: bogus@does.not.exist.com ()
Date: Wed, 06 Oct 2010 22:52:23 -0000
Subject: No subject
Message-ID: <mailman.2.1286473034.390.linux-arm-kernel@lists.infradead.org>

omap_hwmod.  You can think of this change as simply using the runtime PM
API instead of the clock API for enabling and idling the device.

With your ack (on this patch only) we'd like to merge this along with
the rest of the series for 2.6.37.

Kevin
