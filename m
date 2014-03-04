From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Mar 2014 10:17:31 -0800
Subject: [PATCH 1/2] ARM: dts: Add support for OMAP4 Gumstix DuoVero/Parlor
In-Reply-To: <5314549C.1030400@epfl.ch>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <1393261669-32039-2-git-send-email-florian.vaussard@epfl.ch>
 <5314549C.1030400@epfl.ch>
Message-ID: <20140304181731.GD17470@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140303 02:12]:
> Hi Tony, Benoit,
> 
> On 02/24/2014 06:07 PM, Florian Vaussard wrote:
> > Gumstix DuoVero is an OMAP4430-based Computer On Module.
> > Parlor is one of the available expansion board.
> > 
> > Tested features:
> > - GPMC ethernet
> > - HSUSB2 and OTG
> > - Audio out
> > - WiFi and Bluetooth (w2cbw0015 SDIO module)
> > - LED and button
> > 
> 
> Can this patch go into 3.15? The other one (HDMI support) can wait for
> the DSS support to be merged, but I would like to give to this DTS a
> wider exposure to testing opportunities.

Thanks applying into omap-for-v3.15/dt.

Regards,

Tony
