From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 10:46:38 +0100
Subject: [PATCH 03/11] dts: pinctrl: Add GPIO to Pinctrl pin mapping in DT
In-Reply-To: <1445233398-27129-4-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-4-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdZgEzSmzdMYM3tCLLpW7h-K88ALh65KyUKpcTHSqn9eHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> ASIU gpio controller's pins are muxed with pin-cntroller.
> Add this mapping through property "gpio-ranges".
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through the Broadcom Cygnus/ARM SoC tree.

Yours,
Linus Walleij
