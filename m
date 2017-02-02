From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 2 Feb 2017 19:45:58 +0200
Subject: [PATCH v2 3/3] arm64: dts: exynos: Use macros for pinctrl
 configuration on Exynos7
In-Reply-To: <1484885997-21004-4-git-send-email-pankaj.dubey@samsung.com>
References: <1484885997-21004-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170120041722epcas5p174400b9943db114afa311f031f5ba81d@epcas5p1.samsung.com>
 <1484885997-21004-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20170202174558.epha55gfhhc5i3tj@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 09:49:57AM +0530, Pankaj Dubey wrote:
> Usage of DTS macros instead of hard-coded numbers makes code easier to
> read.  One does not have to remember which value means pull-up/down or
> specific driver strength.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   4 +-
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 302 ++++++++++++------------
>  2 files changed, 154 insertions(+), 152 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
