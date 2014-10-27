From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 27 Oct 2014 20:41:25 +0100
Subject: [PATCH 2/8] regulator: max77686: Remove support for board files
In-Reply-To: <1414422226-10948-3-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <544E9FE5.3050909@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/27/2014 04:03 PM, Krzysztof Kozlowski wrote:
> The driver is used only on Exynos4 based boards with DTS support.
> Convert the driver to DTS-only version.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/regulator/max77686.c | 51 +++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
> index c6bf6f79bd2a..04af7a2b0910 100644
> --- a/drivers/regulator/max77686.c
> +++ b/drivers/regulator/max77686.c

I agree with the patch but shouldn't the mfd driver depends on OF if is DT-only?

Best regards,
Javier
