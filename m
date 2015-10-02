From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 05:19:41 -0700
Subject: [PATCH v5 1/7] pinctrl: freescale: imx: fix system crash if
 enable two pinctl instances
In-Reply-To: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
Message-ID: <CACRpkdauecXzxmveqEYRE=-iKf8JoJCj7q8kG+k0AGcDQqYGEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 1:53 PM, Adrian Alonso <aalonso@freescale.com> wrote:

> From: Robin Gong <b38343@freescale.com>
>
> Fix system chrash caused by groups whose number is smaller than the number
> of groups of the last pinctl instance which is not initialized.
>
> iMX7D supports two iomux controllers (iomuxc-lpsr and iomuxc) on probing
> the second instance (iomuxc) the chrash below occurs.

This 1/7 patch applied for next with Shawn's ACK.

Yours,
Linus Walleij
