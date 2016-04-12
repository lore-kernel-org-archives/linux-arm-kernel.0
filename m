From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 12 Apr 2016 14:15:11 +0200
Subject: [PATCH v6 10/10] clocksource: arm_arch_timer: Remove
 arch_timer_get_timecounter
In-Reply-To: <20160412054447.GC16636@linaro.org>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-11-git-send-email-julien.grall@arm.com>
 <20160412054447.GC16636@linaro.org>
Message-ID: <20160412121511.GB3039@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Apr 12, 2016 at 07:44:47AM +0200, Daniel Lezcano wrote:
> On Mon, Apr 11, 2016 at 04:33:00PM +0100, Julien Grall wrote:
> > The only call of arch_timer_get_timecounter (in KVM) has been removed.
> > 
> > Signed-off-by: Julien Grall <julien.grall@arm.com>
> > Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> > 
> > ---
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > 
> >     Changes in v4:
> >         - Add Christoffer's acked-by
> > 
> >     Changes in v3:
> >         - Patch added
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

having acked these, do you want us to just take this a complete series
via the kvmarm tree or do you plan on merging the patches individually?

Thanks,
-Christoffer
