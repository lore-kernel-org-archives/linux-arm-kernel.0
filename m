From: ben-i2c@fluff.org (Ben Dooks)
Date: Wed, 27 Oct 2010 08:35:01 +0100
Subject: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime
	api's
In-Reply-To: <87vd5d9a68.fsf@deeprootsystems.com>
References: <1285078036-12789-2-git-send-email-rnayak@ti.com>
	<1285078036-12789-3-git-send-email-rnayak@ti.com>
	<1285078036-12789-4-git-send-email-rnayak@ti.com>
	<1285078036-12789-5-git-send-email-rnayak@ti.com>
	<1285078036-12789-6-git-send-email-rnayak@ti.com>
	<20100927223645.GJ21564@trinity.fluff.org>
	<0680EC522D0CC943BC586913CF3768C003FF05981F@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C003FF05988F@dbde02.ent.ti.com>
	<20100928233334.GS21564@trinity.fluff.org>
	<87vd5d9a68.fsf@deeprootsystems.com>
Message-ID: <20101027073501.GK21564@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 07, 2010 at 10:37:03AM -0700, Kevin Hilman wrote:
> Ben Dooks <ben-i2c@fluff.org> writes:
> 
> [...]
> 
> > As such, I should really go and read up all about this new runtime-pm
> > and hwmod stuff before further commentign on the changes.
> 
> ping
> 
> >From the drivers perspective, you don't neet to know anything about
> omap_hwmod.  You can think of this change as simply using the runtime PM
> API instead of the clock API for enabling and idling the device.
> 
> With your ack (on this patch only) we'd like to merge this along with
> the rest of the series for 2.6.37.

Acked-by: Ben Dooks <ben-linux@fluff.org>

please post via your tree.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
