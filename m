From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat, 5 Jul 2014 06:56:50 +0100
Subject: [PATCH 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
In-Reply-To: <CAN_we7O2AMpace_oxBoxBO_jT82MnL9B-mzchozncMzp4_kZ=w@mail.gmail.com>
References: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
 <1404472432-24764-2-git-send-email-peter.griffin@linaro.org>
 <CAN_we7O2AMpace_oxBoxBO_jT82MnL9B-mzchozncMzp4_kZ=w@mail.gmail.com>
Message-ID: <20140705055650.GA8146@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniele,

Thankyou for reviewing.

> > +config USB_DWC3_ST
> > +       tristate "STMicroelectronics Platforms"
> > +       depends on ARCH_STI && OF
> > +       default USB_DWC3_HOST
> > +       help
> > +         STMicroelectronics SoCs chip with one DesignWare Core USB3 IP
> > +         inside (i.e. STiH407).
> > +
> >           Say 'Y' or 'M' here if you have one such device
> >
> >  comment "Debugging features"
> 
> you are actually removing the line "Say 'Y' or 'M' here if you have
> one such device" from the previous item

Whoops, good spot. I've fixed in V2, and added the same sentence for this
new entry as well.

I've also replaced "STMicroelectronics SoCs chip with one DesignWare Core"
with "STMicroelectronics SoCs with one DesignWare Core".

regards,

Peter.
