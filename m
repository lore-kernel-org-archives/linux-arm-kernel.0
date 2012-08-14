From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 Aug 2012 16:22:53 +0800
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <CACRpkdZL6efwvUyW1+2j8253WRXm3WYyDUw8rN_o9QE=HER4wA@mail.gmail.com>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdZL6efwvUyW1+2j8253WRXm3WYyDUw8rN_o9QE=HER4wA@mail.gmail.com>
Message-ID: <CAAQ0ZWSuAguQwZkQzkUPqJF5ZBSc5Ekiq6mvtwvp98tuu5noLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2012 16:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> Since I just merged the imx53 driver which *again* start numbering on
> 1, can I have a patch that fixes that driver also?
>
What Uwe added is imx35 (vs. imx53 :) driver, which already numbers pad from 0.

Regards,
Shawn

> Uwe, you OK with this?
>
