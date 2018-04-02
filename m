From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Apr 2018 14:04:14 +0200
Subject: [Question] MFD driver that handles clocks/resets and populates
 child nodes
In-Reply-To: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
Message-ID: <20180402120414.GA8159@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The maintainer of DWC3, Felipe Balbi, requested to
> split the glue layer driver into small parts such as
> reset, regulator, phy, etc.

What exactly did Felipe ask for? Did he ask that the patch be split
up, one patch per reset, regulator, phy etc?

Are all these resources used just by the DWC3? Or is it a true MFD,
multiple functions?

	 Andrew
 
