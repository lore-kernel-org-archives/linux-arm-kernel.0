From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 15:54:00 +0100
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <20140827104231.GB7773@leverpostej>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <20140827104231.GB7773@leverpostej>
Message-ID: <20140827145359.GD13850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 11:42:31AM +0100, Mark Rutland wrote:
> On Wed, Aug 27, 2014 at 10:44:18AM +0100, Naveen Krishna Chatradhi wrote:
> > +       cpus {
> > +               #address-cells = <2>;
> > +               #size-cells = <0>;
> > +
> > +               cpu at 0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a57", "arm,armv8";
> > +                       reg = <0x0 0x0>;
> > +               };
> > +       };
> 
> Only UP?

I see what you meant. Maybe this is populated by firmware and that's
only an example.

-- 
Catalin
