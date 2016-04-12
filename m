From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 12 Apr 2016 07:43:13 +0200
Subject: [PATCH v6 01/10] clocksource: arm_arch_timer: Gather KVM
 specific information in a structure
In-Reply-To: <1460388780-914-2-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-2-git-send-email-julien.grall@arm.com>
Message-ID: <20160412054313.GA16636@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 04:32:51PM +0100, Julien Grall wrote:
> Introduce a structure which are filled up by the arch timer driver and
> used by the virtual timer in KVM.
> 
> The first member of this structure will be the timecounter. More members
> will be added later.
> 
> A stub for the new helper isn't introduced because KVM requires the arch
> timer for both ARM64 and ARM32.
> 
> The function arch_timer_get_timecounter is kept for the time being and
> will be dropped in a subsequent patch.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> 

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
