From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 20 Dec 2016 17:17:14 +0100
Subject: [PATCH v2 3/3] arm64: dts: marvell: Add ethernet switch
 definition for the ESPRESSObin
In-Reply-To: <c27998fd-3807-5c99-382b-b8d0d0f06526@free-electrons.com>
References: <20161220085138.3998-1-romain.perier@free-electrons.com>
 <20161220085138.3998-4-romain.perier@free-electrons.com>
 <20161220154234.GC30952@lunn.ch>
 <c27998fd-3807-5c99-382b-b8d0d0f06526@free-electrons.com>
Message-ID: <20161220161714.GD30952@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>+		mdio {
> >>+			#address-cells = <1>;
> >>+			#size-cells = <0>;
> >>+			reg = <1>;
> >
> >what is this reg value for?
> >
> >     Andrew
> >
> 
> It was required to avoid a warning thrown by the mdio subsystem

Do you remember what the warning was?

This seems odd to me. I don't see why a reg is needed here.

Thanks
	Andrew
