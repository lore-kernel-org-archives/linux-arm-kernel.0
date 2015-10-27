From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 10:43:55 +0100
Subject: [PATCH 01/11] dt-bindings: pinctrl: Optional DT property to
 support pin mappings
In-Reply-To: <1445233398-27129-2-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-2-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdbjjuXR4_KabugBBp1bGi62jRFtaCBKDUjLP+8nxH_4aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> If GPIO controller's pins are muxed, pin-controller subsystem
> need to be intimated by defining mapping between gpio and
> pinmux controller. This patch adds required properties to
> define this mapping via DT.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Applied with Rob's ACK and a tweak to the subject line.

Yours,
Linus Walleij
