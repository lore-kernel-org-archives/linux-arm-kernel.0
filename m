From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 11 Feb 2014 09:01:27 -0800
Subject: ohci-/ehci-platform: Change compatible string to ?hci-platform
In-Reply-To: <1635726.gc3dEs0zOi@wuerfel>
References: <Pine.LNX.4.44L0.1402111023240.1209-100000@iolanthe.rowland.org>
 <1635726.gc3dEs0zOi@wuerfel>
Message-ID: <4195343.2rfzYCCiXV@lenovo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 11 f?vrier 2014, 16:43:37 Arnd Bergmann a ?crit :
> On Tuesday 11 February 2014 10:27:12 Alan Stern wrote:
> > It might even be a good idea to change the "xhci-platform" string to
> > match, it that doesn't cause too much trouble.
> 
> The original xhci binding was contributed by Al Cooper, but I don't
> see any dts files using it. I agree that xhci-generic is a better
> name than xhci-platform, and I think we should make that the recommended
> string. If Al or someone thinks the xhci-generic string might already
> be used in production devices, we should however allow both names
> in the binding and in the driver.

The platform on which "xhci-platform" is currently used is Broadcom STB for 
which Marc submitted the base support recently. The BCM7445 reference DTS will 
probably be updated at some point to reflect that.
-- 
Florian
