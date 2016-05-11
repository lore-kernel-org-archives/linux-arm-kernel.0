From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 20:53:38 +0200
Subject: [PATCH] ARM: dts: exynos: Enable AX88760 USB hub on Origen board
In-Reply-To: <87y47gwj9k.fsf@mattleach.net>
References: <1462950412-16681-1-git-send-email-k.kozlowski@samsung.com>
 <87y47gwj9k.fsf@mattleach.net>
Message-ID: <20160511185338.GA10164@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 07:18:31PM +0100, Matthew Leach wrote:
> Hi Krzysztof,
> 
> Sorry for not acting on the feedback sooner - I lost the email in my
> Inbox!
> 
> I've tested the patch on my Origen board and it works fine.  One small
> comment in-line.
> 
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
> 
> > From: Matthew Leach <matthew@mattleach.net>
> >
> > Enable the Origen's usb phy and ohci devices in the device tree.  Also
> > add the "samsung,vbus-gpio" property to enable the GPX3(5) gpio pin so
> > the AX88760 hub is powered.
> >
> > Signed-off-by: Matthew Leach <matthew@mattleach.net>
> > [k.kozlowski: Extend nodes by label notation instead of path]
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos4412-origen.dts | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> > index 8bca699b7f20..4c59bdb0e6f3 100644
> > --- a/arch/arm/boot/dts/exynos4412-origen.dts
> > +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> > @@ -77,12 +77,29 @@
> >  			clock-frequency = <24000000>;
> >  		};
> >  	};
> > +
> 
> I think we could loose this line break?

Yeah, that slipped through my fingers.

Thanks for testing,
Krzysztof
