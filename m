From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 2 Jan 2017 20:33:48 +0200
Subject: [PATCH v2 3/5] arm64: dts: exynos5433: Add PPMU dt node
In-Reply-To: <1481173091-9728-4-git-send-email-cw00.choi@samsung.com>
References: <1481173091-9728-1-git-send-email-cw00.choi@samsung.com>
 <1481173091-9728-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <20170102183348.k7xtzxwnt4piw7gs@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 01:58:09PM +0900, Chanwoo Choi wrote:
> This patch adds PPMU (Platform Performance Monitoring Unit) Device-tree node
> to measure the utilization of each IP in Exynos SoC.
> 
> - PPMU_D{0|1}_CPU are used to measure the utilization of MIF (Memory Interface)
>   block with VDD_MIF power source.
> - PPMU_D{0|1}_GENERAL are used to measure the utilization of INT(Internal)
>   block with VDD_INT power source.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
Thanks, applied.

Best regards,
Krzysztof
