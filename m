From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 10:45:44 +0100
Subject: [PATCH 02/11] pinctrl: Remove GPIO to Pinctrl pin mapping from
 driver
In-Reply-To: <1445233398-27129-3-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-3-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdYf3v_LUjmqL=011zrmkf2cKEe4G+XjZpO=GYN9EzhYiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> Remove gpio to pinctrl pin mapping code from driver and
> address this through standard property "gpio-ranges".
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Patch applied with a small subject tweak.

Yours,
Linus Walleij
