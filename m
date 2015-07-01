From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 01 Jul 2015 10:40:25 -0700
Subject: [PATCH] gpio: msm: Remove empty msm_gpio_{request,free}()
In-Reply-To: <1435753639-13627-1-git-send-email-geert+renesas@glider.be>
References: <1435753639-13627-1-git-send-email-geert+renesas@glider.be>
Message-ID: <55942609.6020804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2015 05:27 AM, Geert Uytterhoeven wrote:
> gpio_chip.request() and gpio_chip.free() are optional, and can just be
> left unimplemented.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested due to lack of hardware.

Actually we should just delete this driver now that we have an msm8660
pinctrl implementation.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
