From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 23 Mar 2017 20:51:57 +0200
Subject: [PATCH v3 2/2] pinctrl: samsung: Use devres version of
 gpiochip_add_data
In-Reply-To: <1490202935-4708-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490202935-4708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1490202935-4708-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Message-ID: <20170323185157.xsw4u7zkrbk75ta6@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 05:15:35PM +0000, Charles Keepax wrote:
> Use devm_gpiochip_add_data to simplify the error path in
> samsung_gpiolib_register.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> 
> No changes since v2.
> 
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
