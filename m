From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 21 Jan 2017 18:26:49 +0200
Subject: [PATCH v2 1/3] arm64: dts: exynos: Fix drive strength of sd0_xxx
 pin definitions
In-Reply-To: <1484885997-21004-2-git-send-email-pankaj.dubey@samsung.com>
References: <1484885997-21004-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170120041718epcas5p18cfaaaf19279744af1522fee5b739c3f@epcas5p1.samsung.com>
 <1484885997-21004-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20170121162649.y4dntatnz7pcto2k@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 09:49:55AM +0530, Pankaj Dubey wrote:
> As per Exynos7 datasheet FSYS1 pinctrl block does not support drive
> strength value of 0x3. This patch fixes this and update the correct
> drive strength for sd0_xxx pin definitions.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
