From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Aug 2017 15:31:04 +0200
Subject: [PATCH v3 3/4] net: stmmac: register parent MDIO node for
 sun8i-h3-emac
In-Reply-To: <20170821132015.GB1703@lunn.ch>
References: <20170818122118.4925-1-clabbe.montjoie@gmail.com>
 <20170818122118.4925-4-clabbe.montjoie@gmail.com>
 <CAGb2v66KcZkiDDHryMmVzm4WroXePPy3V44SLpVdoO3ZEjgC=g@mail.gmail.com>
 <20170819185025.GB13266@Red> <20170819203836.GA21567@lunn.ch>
 <20170820065757.GA6081@Red> <20170820142545.GB24150@lunn.ch>
 <CAGb2v67hQXSoCKP7qW+KRUYX+0djQ1Z23cQ67Lyg6G7ozGyfGQ@mail.gmail.com>
 <20170821132015.GB1703@lunn.ch>
Message-ID: <20170821133104.qvrhvwin2rdg4aqo@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Aug 21, 2017 at 03:20:15PM +0200, Andrew Lunn wrote:
> > With our hardware, and likely Rockchip's as well, the muxed connections
> > include the MDIO and MII connections
> 
> Ah, i did not realise the MII was muxed as well. Then i agree, an MDIO
> mux is wrong.
> 
> However, please try to make the binding not look like an mdio mux. We
> don't want people misunderstanding the binding and thinking it is an
> mdio mux.

Do you have any suggestion on what the binding would look like?

All muxes are mostly always represented the same way afaik, or do you
want to simply introduce a new compatible / property?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/cbaaf0ea/attachment.sig>
