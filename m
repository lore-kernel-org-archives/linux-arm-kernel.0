From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Jul 2014 15:44:40 +0100
Subject: [PATCH v7 02/24] mfd: max77686: Add power management support
In-Reply-To: <1404505467-26526-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140709144440.GD2635@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jul 2014, Javier Martinez Canillas wrote:

> The driver doesn't have PM operations defined so add a suspend
> and resume function handlers to allow the PMIC IRQ to wakeup
> the system when it is put into a sleep state.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mfd/max77686.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Patch looks good.  I guess the set needs to go in as one big lump due
to interdependencies, so for my own benefit (to prevent re-reviewing):

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
