From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 18 Jan 2016 10:07:14 +0800
Subject: [PATCH 1/2] usb: chipidea: add CI_HDRC_TURN_VBUS_EARLY_ON for
 imx23
In-Reply-To: <245634301.105525.a366f7cd-6533-4e6a-9506-5cc94a8288bd.open-xchange@email.1und1.de>
References: <1451407269-14905-1-git-send-email-stefan.wahren@i2se.com>
 <245634301.105525.a366f7cd-6533-4e6a-9506-5cc94a8288bd.open-xchange@email.1und1.de>
Message-ID: <20160118020713.GA8150@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 17, 2016 at 07:56:31PM +0100, Stefan Wahren wrote:
> Hi Peter,
> 
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 29. Dezember 2015 um 17:41
> > geschrieben:
> >
> >
> > Until now the imx23 uses the imx27 platform flag. But the
> > imx23 needs the flag CI_HDRC_TURN_VBUS_EARLY_ON, too. So
> > fix this by adding a separate platform flag.
> >
> > Suggested-by: Peter Chen <peter.chen@nxp.com>
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> > drivers/usb/chipidea/ci_hdrc_imx.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> 
> is the series okay?

Yes, it is ok, already at my patch queue

-- 

Best Regards,
Peter Chen
