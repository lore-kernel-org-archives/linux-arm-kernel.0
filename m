From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 8 Sep 2014 16:53:31 +0100
Subject: [PATCH 0/3]  Add picoPHY usb phy driver found on stih407 family
 SoC's
In-Reply-To: <540DC9F6.8090306@ti.com>
References: <1409740079-16554-1-git-send-email-peter.griffin@linaro.org>
 <540DC9F6.8090306@ti.com>
Message-ID: <20140908155331.GA7620@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

> On Wednesday 03 September 2014 03:57 PM, Peter Griffin wrote:
> > This series adds support for the picoPHY usb phy which is used by the usb2
> > and usb3 host controllers when controlling usb2/1.1 devices. It is found on
> > stih407 family SoC's from the consumer electronics devision of STMicroelectronics.
> 
> So miphy28lp is the PHY controller for USB3 device controller and picoPHY is
> the PHY controller for USB3 host controller?

No, miphy28lp is the usb3 phy and picoPHY is the usb2 phy.

With a usb2 host controller only picoPHY is used. With the usb3 host controller both usb2 and usb3 phys
are used depending on what type of device is plugged in.

Hope that clarifies things,

regards,

Peter.
