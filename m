From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 14 Sep 2014 19:50:32 +0200
Subject: [PATCH v4 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
In-Reply-To: <1409062680-15906-1-git-send-email-t.figa@samsung.com>
References: <1409062680-15906-1-git-send-email-t.figa@samsung.com>
Message-ID: <5415D568.60802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Olof, Kukjin,

On 26.08.2014 16:17, Tomasz Figa wrote:
> This series intends to add support for L2 cache on Exynos4 SoCs on boards
> running under secure firmware, which requires certain initialization steps
> to be done with help of firmware, as selected registers are writable only
> from secure mode.

I assume that since there has not been any input for almost 3 weeks,
this series can be merged. How should we proceed with it? Note that it
touches both core ARM and Exynos-specific areas and depends on another
Exynos-specific series [1].

[1] [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
    (https://lkml.org/lkml/2014/8/26/445)

Best regards,
Tomasz
