From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 18 Oct 2011 11:39:11 +0800
Subject: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/14 Barry Song <Barry.Song@csr.com>:
> From: Rong Wang <Rong.Wang@csr.com>
>
> SiRFprimaII is the latest generation application processor from CSR?s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
>
> There are three dedicated UARTs in system. This patch adds basic driver
> support for them.
>
> It has used the newest pinmux subsystem from Linus Walleij.

Hi Alan, it means this patch doesn't compile until pinmux tree of
Linus Walleij is merged into mainline.
Now it is a linux next tree.

>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rong Wang <Rong.Wang@csr.com>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
> ?-v2:
> ?rename device name from ttyS to ttySiRF;
> ?use dynamic device major and minor;
> ?support non-Bxxx baudrate;
> ?fix other minor issues Alan Cox required.
>

-barry
