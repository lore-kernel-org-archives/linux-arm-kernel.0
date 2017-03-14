From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 15:37:26 +0100
Subject: [PATCH v2 3/4] phy: exynos-mipi-video: Use consistent method to
 address phy registers
In-Reply-To: <20170311182534.13345-4-krzk@kernel.org>
References: <20170311182534.13345-1-krzk@kernel.org>
 <20170311182534.13345-4-krzk@kernel.org>
 <CGME20170314143728epcas5p37af94136c79bb91b7917036117d29463@epcas5p3.samsung.com>
Message-ID: <3789146.ZdZalfNrev@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 11, 2017 08:25:33 PM Krzysztof Kozlowski wrote:
> Exynos4 MIPI phy registers are defined with macro calculating the offset
> for given phyN.  Use the same method for Exynos5420 to be consistent.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
