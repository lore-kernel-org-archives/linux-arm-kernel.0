From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 31 Aug 2010 09:46:30 -0700
Subject: [PATCH 1/2] msm: Install the Google-Android gpio driver.
In-Reply-To: <1283213906-17671-1-git-send-email-gbean@codeaurora.org>
References: <1283213906-17671-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1283273190.11790.1.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-30 at 17:18 -0700, Gregory Bean wrote:
> struct msm_gpio_chip msm_gpio_chips[] = {
> +       {
> +               .regs = {
> +                       .out =         GPIO_OUT_0,
> +                       .in =          GPIO_IN_0,
> +                       .int_status =  GPIO_INT_STATUS_0,
> +                       .int_clear =   GPIO_INT_CLEAR_0,
> +                       .int_en =      GPIO_INT_EN_0,
> +                       .int_edge =    GPIO_INT_EDGE_0,
> +                       .int_pos =     GPIO_INT_POS_0,
> +                       .oe =          GPIO_OE_0,
> +               }, 

Macro please.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
