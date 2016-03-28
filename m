From: amittomer25@gmail.com (Amit Tomer)
Date: Mon, 28 Mar 2016 21:45:46 +0530
Subject: [RFC PATCH] drivers: pinctrl: add driver for Allwinner A64 SoC
In-Reply-To: <1451582246-32373-1-git-send-email-andre.przywara@arm.com>
References: <1451582246-32373-1-git-send-email-andre.przywara@arm.com>
Message-ID: <CABHD4K-nD9EvbgOPA2WH0q66csqVv18tmeTOBe87ACr4nuQM0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ,

> +       SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 11),
> +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> +                 SUNXI_FUNCTION(0x2, "mic"),           /* DATA */
> +                 SUNXI_FUNCTION_IRQ(0x6, 11)),         /* EINT11 */
> +};
> +

Sorry to intervene here but is there any specific reason for not
covering Bank from PL0 - PL12(as it is mentioned in Datasheet) ?

Thanks,
Amit
