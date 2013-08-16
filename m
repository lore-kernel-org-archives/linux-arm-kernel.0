From: george.cherian@ti.com (George Cherian)
Date: Fri, 16 Aug 2013 15:51:09 +0530
Subject: [PATCH v3] arm: dts: AM43x: Add usb DT nodes for AM4372
In-Reply-To: <520DEBF1.6070605@baylibre.com>
References: <1373444082-4169-1-git-send-email-george.cherian@ti.com>
 <520B9144.5000701@ti.com> <520B958B.1000900@baylibre.com>
 <520D9A3E.1040903@ti.com> <520DEBF1.6070605@baylibre.com>
Message-ID: <520DFD15.9060900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/16/2013 2:38 PM, Benoit Cousson wrote:
> That's fine, but that was not my question. Is there any already bindings
> that defined phys and phy-names in the kernel?

No
>
> I couldn't find them in 3.11-rc5.

I will drop the phy reference and send an updated patch adding dwc nodes.

> And anyway the current bindings for dwc3 is not aligned with what you
> are doing here.
> So you have to change the binding before using it in this DTS.
>
> Regards,
> Benoit


-- 
-George
