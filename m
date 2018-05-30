From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 30 May 2018 15:10:30 -0300
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <20180530173414.6121-1-andrew.smirnov@gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5BbgG2POYvayjT99BAAkC5HzrUWr28Z7DggVwTFSCnpFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 2:34 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Workaround introduced for i.MX53 in be9cae2479f48 ("usb: chipidea:
> imx: Fix ULPI on imx53") seems to be applicable in case of i.MX51 as
> well. Running latest kernel on ZII RDU1 Board (imx51-zii-rdu1.dts)
> exhibits a kernel frozen on PORTSC access and applying the workaround
> resolves the issue.
>
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
