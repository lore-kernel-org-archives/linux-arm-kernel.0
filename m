From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 13:08:31 +0800
Subject: [PATCH v2 00/12] add imx usb driver for mx28/6x
In-Reply-To: <CAOMZO5AcP2cAAkuFPJn3Xp5NuR+JG4hDO7Ehq5H-V6PCy4DwNA@mail.gmail.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <CAOMZO5AcP2cAAkuFPJn3Xp5NuR+JG4hDO7Ehq5H-V6PCy4DwNA@mail.gmail.com>
Message-ID: <20120522050831.GQ6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 04:34:15PM -0300, Fabio Estevam wrote:
> Hi Richard,
> 
> On Mon, May 21, 2012 at 6:23 AM, Richard Zhao
> <richard.zhao@freescale.com> wrote:
> > The work is based on ?ci13xxx rework done by Alexander Shishkin.
> >
> > Status:
> > ?- this version only support host
> > ?- usbotg controler works at host role
> >
> > Changes since V1:
> > ?- Merge the work of Marek
> > ?- re-implement connect change notify
> > ?- imx6q: move part of code to clk
> > ?- imx6q: add config-on-boot gpios
> 
> Can you please also add the driver into the defconfig files?
Thanks for you reminder.
> 
> What about the existing USB host drivers for mx27/mx31/mx35/mx25/mx35?
> 
> Is the idea to switch to drivers/usb/chipidea/host.c too?
Yes. but I'm now just focusing on imx6q and imx28.

Thanks
Richard
> 
> Regards,
> 
> Fabio Estevam
> 
