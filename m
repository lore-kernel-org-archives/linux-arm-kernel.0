From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 20:04:40 +0200
Subject: [PATCH 00/11] Convert GPIO Davinci to platform driver
In-Reply-To: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
Message-ID: <CACRpkdbJY1mZWzFUqWmUR_C8wjis0xtXLOGYNZB9ewqBuxcd5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 9:10 AM, Philip Avinash <avinashphilip@ti.com> wrote:

> GPIO Davinci driver converted to platform driver to support DT booting.
> In this patch series
> - Cleaned gpio Davinci driver code with proper commenting style and appropriate
>   variable names.
> - Create platform driver for GPIO Davinci in da8xx and dm* platforms and removed
>   gpio related member updation in davinci_soc_info structure.
> - DT support added for da850 board and tested on da850 EVM.
> - Remove soc_info reference in the gpio davinci driver and start uses
>   gpiolib interface.

I'll go over and review this. I assume this will then go through
some DaVinci tree and up into ARM SoC when/if I ACK it.

Yours,
Linus Walleij
