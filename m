From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 09:36:49 +0100
Subject: [PATCH v2 3/7] pinctrl: use ngpios propety from DT
In-Reply-To: <1447905139-16002-4-git-send-email-pramodku@broadcom.com>
References: <1447905139-16002-1-git-send-email-pramodku@broadcom.com>
 <1447905139-16002-4-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdYsgAqQaMNwjCSnZy_47JACTyNtW7qfUKSk4f0=1GPV0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 4:52 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> Since identical hardware is used in several instances and every
> instance will have different in-use pins. Hence extracting this
> number from DT via "ngpios" property.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Patch applied.

Yours,
Linus Walleij
