From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 21 May 2012 16:34:15 -0300
Subject: [PATCH v2 00/12] add imx usb driver for mx28/6x
In-Reply-To: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <CAOMZO5AcP2cAAkuFPJn3Xp5NuR+JG4hDO7Ehq5H-V6PCy4DwNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Mon, May 21, 2012 at 6:23 AM, Richard Zhao
<richard.zhao@freescale.com> wrote:
> The work is based on ?ci13xxx rework done by Alexander Shishkin.
>
> Status:
> ?- this version only support host
> ?- usbotg controler works at host role
>
> Changes since V1:
> ?- Merge the work of Marek
> ?- re-implement connect change notify
> ?- imx6q: move part of code to clk
> ?- imx6q: add config-on-boot gpios

Can you please also add the driver into the defconfig files?

What about the existing USB host drivers for mx27/mx31/mx35/mx25/mx35?

Is the idea to switch to drivers/usb/chipidea/host.c too?

Regards,

Fabio Estevam
