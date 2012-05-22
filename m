From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 May 2012 11:32:59 +0800
Subject: [PATCH v2 07/12] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <201205220525.39660.marex@denx.de>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-8-git-send-email-richard.zhao@freescale.com>
 <20120522031709.GH8140@S2101-09.ap.freescale.net>
 <201205220525.39660.marex@denx.de>
Message-ID: <CAAQ0ZWSiD170Yb5CQdGEZw066ULvSOr4AFcBtYFiLw3P9L-VuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2012 11:25, Marek Vasut <marex@denx.de> wrote:
> Dear Shawn Guo,
>
>> Apart from my comments below, we really need to know Rob and Grant's
>> opinion on this.
>
> Hm ... so why don't you actually write per-board driver ? :-) That'd handle
> every single board very well, you'd configure the GPIOs there, every single
> additional necessary thing that has to be configured would sink there too etc.
>
I'm not completely sure about how the per-board driver looks like
exactly.  Can you have some code demonstrating it?

Regards,
Shawn
