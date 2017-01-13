From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 13 Jan 2017 19:08:41 +0530
Subject: [PATCH v3 03/15] ARM: davinci: Don't rely on public mmc header to
 include interrupt.h
In-Reply-To: <1484313256-25993-4-git-send-email-ulf.hansson@linaro.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <d1b15248-4609-e0a1-49b3-41605f5eefd3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 January 2017 06:44 PM, Ulf Hansson wrote:
> The davinci board omapl138-hawk, depends on interrupt.h. Explicitly include
> it instead of relying on the public mmc header host.h.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Additionally checked that 02/15 and 03/15 do not clash with anything I
have queued so far. And built test my tree + these two patches with
davinci_all_defconfig.

Thanks,
Sekhar
