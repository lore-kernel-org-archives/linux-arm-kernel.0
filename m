From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 13 Apr 2013 17:41:26 -0300
Subject: [PATCH] tty/serial: add MVF uart driver support
In-Reply-To: <1365750655-3530-1-git-send-email-b35083@freescale.com>
References: <1365750655-3530-1-git-send-email-b35083@freescale.com>
Message-ID: <CAOMZO5D-uQQJAc6zAMkF9ViR0KWg4q7cPr7+pLdfyAm9gtPyTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 4:10 AM, Jingchang Lu <b35083@freescale.com> wrote:
> It adds Freescale Vybrid Family uart driver support
>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  drivers/tty/serial/Kconfig       |   17 +
>  drivers/tty/serial/Makefile      |    1 +
>  drivers/tty/serial/mvf.c         | 1246 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |    3 +
>  4 files changed, 1267 insertions(+)
>  create mode 100644 drivers/tty/serial/mvf.c

Would it be possible to add Vybrid support into the existing imx serial port?
