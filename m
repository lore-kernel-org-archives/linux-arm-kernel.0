From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 11 Sep 2014 14:25:34 -0700
Subject: [PATCH v2 3/9] ARM: meson: serial: add MesonX SoC on-chip uart
 driver
In-Reply-To: <1410466300-19168-4-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
 <1410466300-19168-4-git-send-email-carlo@caione.org>
Message-ID: <20140911212534.GA17251@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 10:11:34PM +0200, Carlo Caione wrote:
> The SoC has four fully functional UARTs which use the same programming
> model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
> which cannot be powered off.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  drivers/tty/serial/Kconfig       |  18 ++
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/meson_uart.c  | 634 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 656 insertions(+)
>  create mode 100644 drivers/tty/serial/meson_uart.c

I've already taken this patch, why resend it?

confused,

greg k-h
