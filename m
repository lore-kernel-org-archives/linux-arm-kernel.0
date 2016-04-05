From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 5 Apr 2016 15:15:29 +0200
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <5703651F.4040901@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3108005.nUMWsj4kjp@wuerfel> <20160329212842.GN2350@sirena.org.uk>
 <13533301.gfdhE3AuMf@wuerfel> <5703651F.4040901@denx.de>
Message-ID: <20160405131529.GA30881@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This will make the SPI driver patch very simple but will generate quite
> a big Armada dts change, moving all the SPI controllers from the
> 'internal-regs' node to the 'soc' node though.

Hi Stefan

There was been talk about making use of the labels in dts files,
rather than keeping with the tree structure. So while you are moving
the spi nodes, made you can also change the style.

    Andrew
