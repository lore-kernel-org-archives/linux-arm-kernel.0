From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 14 Apr 2017 11:03:11 +0200
Subject: [PATCH 3/3] arm64: dts: exynos: Add support for S6E3HA2 edge
 panel device on TM2e board
In-Reply-To: <1492147179-7824-4-git-send-email-hoegeun.kwon@samsung.com>
References: <1492147179-7824-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170414051959epcas1p3a246070b065129c4ffbf94736cde321a@epcas1p3.samsung.com>
 <1492147179-7824-4-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170414090311.ysmewlnlk2rtsslp@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 02:19:39PM +0900, Hoegeun Kwon wrote:
> This patch add the panel device tree node for S6E3HA2 edge display
> controller to TM2e dts.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Looks good to me but I see that bindings are discussed still. I'll take
this when they settle.

Best regards,
Krzysztof
