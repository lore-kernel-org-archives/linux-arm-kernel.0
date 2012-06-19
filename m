From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 19 Jun 2012 14:59:09 +0200
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <CAOMZO5A+eWXsz5_HGzUMJBDKnADrMeWPec7XvX+EMPJMtqWcng@mail.gmail.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <20120619061414.GD21951@S2101-09.ap.freescale.net>
 <CAOMZO5A+eWXsz5_HGzUMJBDKnADrMeWPec7XvX+EMPJMtqWcng@mail.gmail.com>
Message-ID: <201206191459.10592.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Hi Shawn,
> 
> On Tue, Jun 19, 2012 at 3:14 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >> Attached my .config file.
> > 
> > You haven't enabled the following two in your .config.
> > 
> > CONFIG_USB_CHIPIDEA
> > CONFIG_USB_CHIPIDEA_HOST
> 
> Please check my config file again:
> 
> It does have:
> 
> CONFIG_USB_CHIPIDEA=y
> CONFIG_USB_CHIPIDEA_HOST=y
> 
> Can someone confirm that this patch series works on a mx28evk? If it
> does, please send me the .config that works.

T-22 (+small delta) hours and counting ...

> Thanks,
> 
> Fabio Estevam

Best regards,
Marek Vasut
