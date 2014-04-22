From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 13:43:03 +0200
Subject: [PATCH v3 4/7] pinctrl: sunxi: support multiple pin controller
In-Reply-To: <1397137966-30818-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CACRpkdZLkDM68uRAKH1c2UeAL5isDEK8eFqpEw63K2TxNOPxeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 3:52 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:

> Add support for multiple pin controller instances.
>
> First remove the static definition of the sunxi gpio chip struct and fill
> the dynamically struct instead.
> Then define a new pin_base field in the sunxi_pinctrl_desc which will be
> used to specify the gpiochip base pin.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
