From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 2 Feb 2017 19:54:46 +0200
Subject: [PATCH v3 2/2] arm64: dts: exynos: Add regulators for Vbus and
 Vbus-Boost
In-Reply-To: <1484721173-30474-3-git-send-email-pankaj.dubey@samsung.com>
References: <1484721173-30474-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170118063009epcas5p27f555398c9f3f44d733e04a585e74139@epcas5p2.samsung.com>
 <1484721173-30474-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20170202175446.tn665r5u75pj2uin@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 12:02:53PM +0530, Pankaj Dubey wrote:
> From: Vivek Gautam <gautamvivek1987@gmail.com>
> 
> Adding fixed voltage regulators for Vbus and Vbus-boost required
> by USB 3.0 DRD controller on Exynos7-espresso board.
> 
> Signed-off-by: Vivek Gautam <gautamvivek1987@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 45 +++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Thanks, applied with re-ordered nodes.

Best regards,
Krzysztof
