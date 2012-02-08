From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 7 Feb 2012 22:17:34 -0200
Subject: [PATCH] EHCI: Fix clk_enable/clk_disable for ehci-mxc usb clock
In-Reply-To: <1328659975-3534-1-git-send-email-marek.vasut@gmail.com>
References: <1328659975-3534-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <CAOMZO5Bi+xMGmD=d=9bAHZE8t5PDurSZA5yNdOEj0xJwtbT-vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2012 at 10:12 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> The clock weren't enabled without the following change.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

You forgot to Cc linux-usb.

Regards,

Fabio Estevam
