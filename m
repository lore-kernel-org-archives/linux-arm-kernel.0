From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 20:12:05 +0200
Subject: [PATCH v8 1/7] irqchip: vic: Parse interrupt and resume masks
 from device tree
In-Reply-To: <1500724.07LRpFtgcx@flatron>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1377120111-25601-2-git-send-email-tomasz.figa@gmail.com>
 <1500724.07LRpFtgcx@flatron>
Message-ID: <CACRpkdZEJTCx4RwNCdLfYNDQauO32iMJwJP0eZevTfyV0S-TwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 1:22 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> This patch extends vic_of_init to parse valid interrupt sources
> and resume sources masks from device tree.
>
> If mask values are not specified in device tree, all sources
> are assumed to be valid, as before this patch.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/vic.txt | 6 ++++++
>  drivers/irqchip/irq-vic.c                     | 7 ++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> Changes since v7:
>  - Renamed interrupt-mask property to valid-mask, for consistency with
>    bindings of other interrupt controllers.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
