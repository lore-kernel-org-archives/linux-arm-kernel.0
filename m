From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 20:37:03 +0100
Subject: [PATCH 1/9] sh-pfc: Add OF support
In-Reply-To: <1360726161-16072-2-git-send-email-horms+renesas@verge.net.au>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
 <1360726161-16072-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CACRpkdYetPi=-wz+ESkJz_2LmfgDttUytwa8CAQNWu101aVtbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 4:29 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Support device instantiation through the device tree. The compatible
> property is used to select the SoC pinmux information.
>
> Set the gpio_chip device field to the PFC device to enable automatic
> GPIO OF support.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
