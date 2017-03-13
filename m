From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 13 Mar 2017 14:36:41 +0100
Subject: [PATCH] ARM: dts: imx: add Gateworks Ventana GW5904 support
In-Reply-To: <CAJ+vNU0JNQuQEmG_oCu86cbG_wisVFRETNtCO1bC2ytMM+N2Vg@mail.gmail.com>
References: <1489178411-6559-1-git-send-email-tharvey@gateworks.com>
 <04584d61-f1e2-3722-1f13-ff133edc0c22@gmail.com>
 <CAJ+vNU1NcW=y_c-jJBnAaOozrzYJAekd9BEiMdd2=Bpx=Ng79Q@mail.gmail.com>
 <b105d1ea-7975-bd21-0aa0-762060ceb62a@gmail.com>
 <20170311030426.GB6677@lunn.ch>
 <CAJ+vNU0JNQuQEmG_oCu86cbG_wisVFRETNtCO1bC2ytMM+N2Vg@mail.gmail.com>
Message-ID: <20170313133641.GC748@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks for the hint on the compatibility. I wonder if
> Documentation/devicetree/bindings/net/dsa/marvell.txt should have some
> notes added about switch device compatibility? It wasn't clear to me
> that these would be compatible.

Hi Tim

This keeps coming up, so i plan on submitting a patch. I thought it
would be obvious. The driver supports over 20 Marvell switches, yet
only has two compatible strings. It is not too big a leap to figure
out they must all be compatible, or there would be 20 compatible
strings....

> What is the convention, if any, of the naming of the 'lan' ports (0
> based vs 1 based, eth vs lan)? Is it strictly up to the board vendor?
> The board I'm supporting has a silkscreen that shows 'Port 1' through
> 'Port 4' so I was leaning towards 1 based.

I recommend following what the label on the housing says. If you don't
have a housing, just a board, follow the silk screen, and hope the
designer of the housing also follows the silk screen.

	 Andrew
