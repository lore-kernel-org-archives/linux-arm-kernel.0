From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Feb 2015 15:18:39 +0100
Subject: [PATCH 03/10] devicetree: bindings: add Device Tree bindings for
 Armada 39x pin-muxing controller
In-Reply-To: <20150220121134.25cb865c@free-electrons.com>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1423238276-9206-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150206170521.GX25985@lunn.ch>
 <20150220121134.25cb865c@free-electrons.com>
Message-ID: <20150220141839.GA13797@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Both "dev" and "m" are already used by many of the existing pinctrl DT
> bindings for Marvell platforms, so I'm not sure documenting them
> specifically in the Armada 39x pinctrl DT binding document makes a lot
> of sense. Where should we document them, then? In the generic
> 'marvell,mvebu-pinctrl.txt' DT binding file ?

Hi Thomas

Yes, that would be a good place to list them.

Thanks
	Andrew
