From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 3 May 2016 12:25:51 +0200
Subject: [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
In-Reply-To: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <20160503102551.GC3956@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 12:57:38PM +0900, Chanwoo Choi wrote:
> This patch-set includes the two features as following. The generic exynos bus
> frequency driver is able to support almost Exynos SoCs for bus frequency
> scaling. And the new passive governor is able to make the dependency on
> between devices for frequency/voltage scaling. I had posted the patch-set[1]
> with the similiar concept. This is is revised version for exynos bus frequency.
> - Generic exynos bus frequency driver
> - New passive governor of DEVFREQ framework
> [1] https://lkml.org/lkml/2015/1/7/872
> : [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency driver

Applied DTS patches for late v4.7 (hopefully).

Best regards,
Krzysztof
