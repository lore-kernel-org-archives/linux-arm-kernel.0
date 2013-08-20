From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 20 Aug 2013 18:14:52 +0100
Subject: [PATCH v3 0/6] ARM/ARM64 architected timer updates
In-Reply-To: <1376414984-14182-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376414984-14182-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <5213A40C.6060509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/13 18:29, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> This patch series adds support to configure the rate and enable the
> event stream for architected timer. The event streams can be used to
> impose a timeout on a WFE, to safeguard against any programming error
> in case an expected event is not generated or even to implement
> wfe-based timeouts for userspace locking implementations.
> 
> Since the timer control register is reset to zero on warm boot, CPU
> PM notifier is added to re-initialize it.
> 
> Changes v2->v3:
> 1. Moved ARM and ARM64 changes into separate patches
> 2. Added native hwcaps definations(ARM/ARM64) and compat-specific
>    definitions(ARM64) to the users for the event stream feature. 
> 
Hi Catalin,

Can you review this version of the series ?

Regards,
Sudeep
