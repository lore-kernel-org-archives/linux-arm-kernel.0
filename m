From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Jun 2017 14:35:49 +0200
Subject: [PATCH V5 1/1] dt-bindings: pinctrl: extend the pinmux property
 to support integers array
In-Reply-To: <1498142940-7982-1-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-2-git-send-email-aisheng.dong@nxp.com>
 <1498142940-7982-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdZ=tgnOZJWOCHOPvS+V7q2LcfyRjOjb2XEHAprAfQAWfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 4:49 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> Some platforms may need more than one integer to represent a complete
> pinmux binding, so let's extend the pinmux property to allow to accept
> integer array instead of only a single integer.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> ---
> ChangeLog:
> v4->v5:
>  * doc improvement

Patch applied with Rob's ACK.

Yours,
Linus Walleij
