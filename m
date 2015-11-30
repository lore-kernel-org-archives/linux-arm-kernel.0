From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 09:44:45 +0100
Subject: [PATCH v2 7/7] pinctrl: Rename gpio driver from cygnus to iproc
In-Reply-To: <1447905139-16002-8-git-send-email-pramodku@broadcom.com>
References: <1447905139-16002-1-git-send-email-pramodku@broadcom.com>
 <1447905139-16002-8-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdZmJC3K24VYj+zRg3J=XkiuZoWOdhsNN1mpBacBrsFYgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 4:52 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> Rename gpio driver file name from pinctrl-cygnus-gpio.c to
> pinctrl-iproc-gpio.c to make it more generic so that all
> iproc based future SoCs using the same gpio block could
> use this driver.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Acked-by: Rob Herring <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij
