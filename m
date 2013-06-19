From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 19 Jun 2013 17:21:58 +0530
Subject: [PATCH v2 3/7] ARM: davinci: da8xx: creation of gpio platform
 device
In-Reply-To: <1371202532-14628-4-git-send-email-avinashphilip@ti.com>
References: <1371202532-14628-1-git-send-email-avinashphilip@ti.com>
 <1371202532-14628-4-git-send-email-avinashphilip@ti.com>
Message-ID: <51C19B5E.6030907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2013 3:05 PM, Philip Avinash wrote:
> From: KV Sujith <sujithkv@ti.com>
> 
> gpio controller resource information being associated with
> davinci_soc_info structure and not created any device. Hence davinci
> gpio didn't fall under proper device model. This patch creates gpio
> davinci as a platform device for da8xx platforms.

I didn't really find the description coherent. I simplified it to:

    ARM: davinci: da8xx: support gpio platform device

    DaVinci GPIO driver now uses platform device model.
    Convert DA8XX SoC code to use the new model.

    - Add Memory and IRQ resources for da8xx
    - Add da8xx_register_gpio API to create platform device for da8xx
      platforms.

    Signed-off-by: KV Sujith <sujithkv@ti.com>
    Signed-off-by: Philip Avinash <avinashphilip@ti.com>
    Acked-by: Linus Walleij <linus.walleij@linaro.org>
    [nsekhar at ti.com: simplify commit message]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Before applying the patch.

Thanks,
Sekhar
