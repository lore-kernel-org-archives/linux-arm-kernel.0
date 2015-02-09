From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Mon, 09 Feb 2015 21:24:06 +0100
Subject: [PATCH] exynos: pmu: use PS_HOLD based poweroff for all
 supported SoCs
In-Reply-To: <1423466741-11421-1-git-send-email-m.szyprowski@samsung.com>
References: <1423466741-11421-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <54D91766.4080400@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> PS_HOLD based power off procedure is common for all Exynos SoCs, so use
> it for every Exynos SoC.


Tested on my Odroid-X2 and it seems to solve the 'heating issue' when
the system is shut down but left on the AC adapter.

With best wishes,
Tobias
