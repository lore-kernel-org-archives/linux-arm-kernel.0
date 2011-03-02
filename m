From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 1 Mar 2011 22:21:53 -0300
Subject: [PATCH V4 1/4] ARM: imx53_loco: add esdhc device support
In-Reply-To: <1298973500-2858-1-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1298973500-2858-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <AANLkTinR9+tFVfNb626LF4TSc8c+8a+rSUNvQB7DwSUZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 1, 2011 at 6:58 AM, Richard Zhu <Hong-Xing.Zhu@freescale.com> wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> ?arch/arm/mach-mx5/Kconfig ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mx5/board-mx53_loco.c | ? ?2 ++
> ?2 files changed, 3 insertions(+), 0 deletions(-)

I thought you were going to put this patch as the last of the series.

It is strange to add support for the board first and add the support
for the MX53 later.

Regards,

Fabio Estevam
