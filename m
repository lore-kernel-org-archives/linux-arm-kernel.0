From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 11:48:02 +0200
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <CAAQ0ZWSuAguQwZkQzkUPqJF5ZBSc5Ekiq6mvtwvp98tuu5noLg@mail.gmail.com>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdZL6efwvUyW1+2j8253WRXm3WYyDUw8rN_o9QE=HER4wA@mail.gmail.com>
 <CAAQ0ZWSuAguQwZkQzkUPqJF5ZBSc5Ekiq6mvtwvp98tuu5noLg@mail.gmail.com>
Message-ID: <CACRpkdZn5DFNssCNPvBwXt3AYhXnn6qi1+DXEwjCbqUL65gPOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 10:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On 14 August 2012 16:13, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Since I just merged the imx53 driver which *again* start numbering on
>> 1, can I have a patch that fixes that driver also?
>>
> What Uwe added is imx35 (vs. imx53 :) driver, which already numbers pad from 0.

Yes I was confused... I mixed up imx35 and imx53 again.

Yours,
Linus Walleij
