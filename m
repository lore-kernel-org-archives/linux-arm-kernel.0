From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 18 Jan 2018 14:00:26 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180118123141.GA2839@e107981-ln.cambridge.arm.com>
References: <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell>
 <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell>
 <20180108154243.GA30962@lunn.ch>
 <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
 <20180109101941.GD31502@xora-haswell>
 <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
 <20180109130012.GA27447@lunn.ch>
 <20180118123141.GA2839@e107981-ln.cambridge.arm.com>
Message-ID: <20180118130026.GG32299@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I CC'ed Mika since he is more familiar with handling these bits of ACPI
> specs - I wonder whether this is a problem that cropped up on x86
> systems too.

Hi Lorenzo

There is nothing about MDIO, PHYs, Ethernet switches, etc in version
6.2 of the spec. If x86 has this, it must be after 6.2 was released.
I would not be too surprised if x86 has none of this. If you look at
the typical drives used on x86, i210, e1000e, ixgb, r8169, etc. They
are all PCI devices, and hide all this.

> I do not think there is one and only answer but there must be a single
> set of bindings and if the ACPI specs already cater for some of them
> we have to reuse them.

Agreed. Due diligence so far suggests there is nothing already
defined. But im a newbie to ACPI, so could be looking in the wrong
place. I really hope there is somebody like Rob Herring, the DT
maintainer, who keeps an eye on all ACPI talk and would tell us if we
are heading off in the wrong direction.

    Andrew
