From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Mon, 21 Apr 2014 10:23:30 +0530
Subject: [RFC PATCH 0/2] usb: Reuse fsl driver code for synopsys usb
 controller
In-Reply-To: <5354175B.3070109@pengutronix.de>
References: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
 <5354175B.3070109@pengutronix.de>
Message-ID: <CAGnW=Bav_Q_ZpkFq0gG7m9+OBnPWyPhOoBTNnP=VdErzcwe2dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 12:22 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04/20/2014 06:27 PM, Punnaiah Choudary Kalluri wrote:
>> Zynq soc contains a dual role usb controller and this IP is from synopsys. We
>> observed that there is driver available for this controller from freescale and
>> decided to reuse this driver for zynq use.
>
> Have a look drivers/usb/chipidea. It's maintained by Peter Chen (Cc'ed)
> and is in better shape than the freescale driver.

Thanks. I will check this implementation and also check with Peter Chen if
i have any concerns about this implementation.

Punnaiah.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
