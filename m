From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 29 Oct 2014 12:34:57 +0100
Subject: [PATCH v6 2/3] regulator: max77802: Remove suspend_enable
In-Reply-To: <1414581294-1315-3-git-send-email-k.kozlowski@samsung.com>
References: <1414581294-1315-1-git-send-email-k.kozlowski@samsung.com>
 <1414581294-1315-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5450D0E1.7040904@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/29/2014 12:14 PM, Krzysztof Kozlowski wrote:
> The Maxim 77802 PMIC regulators do not have special enable configuration
> for suspend. The driver instead enabled them manually which is not a
> best way to deal with suspend.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/regulator/max77802.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/regulator/max77802.c b/drivers/regulator/max77802.c
> index 5839c4509e1f..b9958d927297 100644
> --- a/drivers/regulator/max77802.c
> +++ b/drivers/regulator/max77802.c

After what Mark explained, I understand this is the right thing to do.

Acked-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
