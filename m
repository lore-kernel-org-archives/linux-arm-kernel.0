From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Wed, 10 Sep 2014 09:58:29 +0200
Subject: [PATCH] clk: samsung: exynos5260: fix typo in clock name
In-Reply-To: <1410328565-25122-1-git-send-email-pankaj.dubey@samsung.com>
References: <1410328565-25122-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <541004A5.50802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.09.2014 07:56, Pankaj Dubey wrote:
> From: Chander Kashyap <k.chander@samsung.com>
>
> The parent name added in parent list as
> mout_phyclk_mipi_dphy_4l_m_txbyte_clkhs_p, is different
> than the defined parent due to typo.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5260.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

>
> diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
> index 64596ba..4db4e8d 100644
> --- a/drivers/clk/samsung/clk-exynos5260.c
> +++ b/drivers/clk/samsung/clk-exynos5260.c
> @@ -1579,7 +1579,7 @@ struct samsung_fixed_rate_clock fixed_rate_clks[] __initdata = {
>   	FRATE(PHYCLK_HDMI_LINK_O_TMDS_CLKHI, "phyclk_hdmi_link_o_tmds_clkhi",
>   			NULL, CLK_IS_ROOT, 125000000),
>   	FRATE(PHYCLK_MIPI_DPHY_4L_M_TXBYTECLKHS,
> -			"phyclk_mipi_dphy_4l_m_txbyteclkhs" , NULL,
> +			"phyclk_mipi_dphy_4l_m_txbyte_clkhs" , NULL,
>   			CLK_IS_ROOT, 187500000),
>   	FRATE(PHYCLK_DPTX_PHY_O_REF_CLK_24M, "phyclk_dptx_phy_o_ref_clk_24m",
>   			NULL, CLK_IS_ROOT, 24000000),
>
