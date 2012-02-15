From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Feb 2012 21:29:27 -0200
Subject: [PATCH v2 5/7] ARM: imx: eliminate macro IRQ_GPIOx()
In-Reply-To: <1329331668-30325-6-git-send-email-shawn.guo@linaro.org>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
 <1329331668-30325-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOMZO5AZvzbMmMSvMDVE5Xi7JoKkOttdN96Vai0k8ZH5TKdmbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 4:47 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> +#define IMX_GPIOA(x) ?(GPIO_PORTA + x)
> +#define IMX_GPIOB(x) ?(GPIO_PORTB + x)
> +#define IMX_GPIOC(x) ?(GPIO_PORTC + x)
> +#define IMX_GPIOD(x) ?(GPIO_PORTD + x)
> +#define IMX_GPIOE(x) ?(GPIO_PORTE + x)
> +#define IMX_GPIOF(x) ?(GPIO_PORTF + x)

Do we really need this new macros?

Why not use the standard IMX_GPIO_NR macro instead?
