From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 2 Feb 2017 19:49:47 +0200
Subject: [PATCH v3 1/2] arm64: dts: exynos: Add USB 3.0 controller node
 for Exynos7
In-Reply-To: <1484721173-30474-2-git-send-email-pankaj.dubey@samsung.com>
References: <1484721173-30474-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170118063008epcas5p26a5a1fd73d843b2b08eae0fdb03b775c@epcas5p2.samsung.com>
 <1484721173-30474-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20170202174947.twehjebyseycperh@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 12:02:52PM +0530, Pankaj Dubey wrote:
> From: Vivek Gautam <gautamvivek1987@gmail.com>
> 
> Add USB 3.0 DRD controller device node, with its clock
> and phy information to enable the same on Exynos7.
> 
> Signed-off-by: Vivek Gautam <gautamvivek1987@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
