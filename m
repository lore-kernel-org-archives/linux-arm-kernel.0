From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 27 Mar 2013 11:46:05 -0700
Subject: [PATCH 8/9] ARM: OMAP4: PM: Remove L4 wakeup depedency with MPU
 since errata fix exist now
In-Reply-To: <1361373527-21695-9-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Wed, 20 Feb 2013 20:48:46 +0530")
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-9-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <874nfw7kb6.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> With commit bfd6d021 {ARM: OMAP3+: Implement timer workaround for errata
> i103 and i767}, the sync and gptimer synchronization errata got fixed.
>
> Hence the l4_wakeup static dependency with MPU can  can be removed
> now. Static dependency was one of the proposed workaround but from
> power savings perspective, it isn't an ideal workaround.
>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Nice.

Acked-by: Kevin Hilman <khilman@linaro.org>
