From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 13 Jan 2017 18:56:12 +0530
Subject: [PATCH v3 02/15] ARM: davinci: Don't rely on public mmc header to
 include leds.h
In-Reply-To: <1484313256-25993-3-git-send-email-ulf.hansson@linaro.org>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <ccc2cc5c-b9a9-aca2-9677-22c5cd698ad7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 January 2017 06:44 PM, Ulf Hansson wrote:
> Some of the davinci boards, da850-evm, dm644x-evm and neuros-osd2 depends
> on leds.h. Explicitly include it instead of relying on the public mmc
> header host.h.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
