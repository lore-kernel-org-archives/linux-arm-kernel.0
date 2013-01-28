From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jan 2013 11:16:34 +0100
Subject: [PATCH 1/2] gpio: pca953x: use simple irqdomain
In-Reply-To: <1359133168-14879-2-git-send-email-gregory.clement@free-electrons.com>
References: <1359133168-14879-1-git-send-email-gregory.clement@free-electrons.com>
 <1359133168-14879-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYXfCJgMYJtqn3YwLDw6kGQniMiwUv-C861o-0XbHZrBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 5:59 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> This switches the legacy irqdomain to the simple one, which will
> auto-allocate descriptors, and also make sure that we use
> irq_create_mapping() in the to_irq function. Also use the map function
> of irq_domain_ops to setup the irq configuration on demand and no more
> statically during the initialization of the driver.
>
> Based on a initial patch from Linus Walleij <linus.walleij@linaro.org>
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied!

Thanks,
Linus Walleij
