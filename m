From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 Apr 2016 19:26:06 +0200
Subject: [PATCH v5 1/9] clocksource: arm_arch_timer: Gather KVM specific
 information in a structure
In-Reply-To: <1459769860-6629-2-git-send-email-julien.grall@arm.com>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-2-git-send-email-julien.grall@arm.com>
Message-ID: <20160406172606.GG8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 12:37:32PM +0100, Julien Grall wrote:
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
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
