From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Aug 2012 16:46:17 -0700
Subject: [PATCH 01/17] ASoC: Ux500: Move MSP pinctrl setup into the MSP
 driver
In-Reply-To: <1345816913-4113-2-git-send-email-lee.jones@linaro.org>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdai+RObHsq7xe0+Fk24K7r-Wzoc8o3RbvHT78=EeHkjSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 7:01 AM, Lee Jones <lee.jones@linaro.org> wrote:

> In the initial submission of the MSP driver msp1 and msp3's associated
> pinctrl mechanism was passed back to platform code using a plat_init()
> call-back routine, but it has no place in platform code. The MSP driver
> should set this up for the appropriate ports. Instead we use a use_pinctrl
> identifier which is passed from platform_data/Device Tree which indicates
> which ports should use pinctrl.
>
> CC: alsa-devel at alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me, so Acked-by: Linus Walleij <linus.walleij@linaro.org>
for the ux500 mach part.

However I'd request Ola/Roger to ACK it too on the ALSA side.

Yours,
Linus Walleij
