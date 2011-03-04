From: ben@trinity.fluff.org (Ben Dooks)
Date: Fri, 4 Mar 2011 17:17:23 +0000
Subject: [PATCH] i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup
In-Reply-To: <87ei6mizxr.fsf@ti.com>
References: <1299245544-23790-1-git-send-email-rnayak@ti.com>
	<87ei6mizxr.fsf@ti.com>
Message-ID: <20110304171723.GF17460@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 09:00:00AM -0800, Kevin Hilman wrote:
> Rajendra Nayak <rnayak@ti.com> writes:
> 
> > For the I2C module to be wakeup capable, programming I2C_WE
> > register (which was skipped for OMAP4430) is needed
> > even on OMAP4.
> > This fixes i2c controller timeouts which were seen recently
> > with the static dependency being cleared between MPU and
> > L4PER clockdomains.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> > Patch is based on 2.6.38-rc7 kernel.
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Ben, looks like another fix that should be queued for 2.6.38-rc.

I'll put together the couple of fixes I've got and send them to Linus
at the end of the weekend.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
