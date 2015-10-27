From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 10:49:09 +0100
Subject: [PATCH 04/11] dt-binding: Add new compatible string for gpio
 controller driver
In-Reply-To: <1445233398-27129-5-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-5-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdZ8xaoGs2aTzdV2o2s0yDQUT=+Ma4-hp1KhmLckE1-YdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> This new compatible string, "brcm,iproc-gpio", should be used for
> all new iproc-based future SoCs.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Patch applied with subject tweak.

Think about Rob's comment to add an overarching SoC
compatible string, please.

Yours,
Linus Walleij
