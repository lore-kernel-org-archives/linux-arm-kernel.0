From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 May 2014 11:47:39 +0200
Subject: [PATCH v2 04/11] ARM: integrator: convert to use irqchip_init
In-Reply-To: <1401403221-27523-5-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
 <1401403221-27523-5-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdZ=y_gftqHHr2CFacPpnmTvNh+73pUk1M2jmVVKLqdgMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 12:40 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Now that versatile-fpga irqchip has IRQCHIP_DECLARE support, the interrupt
> related initialization can be removed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2:
> - New patch

Awesomeness, Acked-by.
Will provide Tested-by tags too once I get it running.

Yours,
Linus Walleij
