From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 5 Apr 2016 15:31:58 +0200
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <5703BB82.4090204@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3108005.nUMWsj4kjp@wuerfel> <20160329212842.GN2350@sirena.org.uk>
 <13533301.gfdhE3AuMf@wuerfel> <5703651F.4040901@denx.de>
 <20160405131529.GA30881@lunn.ch> <5703BB82.4090204@denx.de>
Message-ID: <20160405133158.GC30881@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yes, I wanted to suggest this change as well. I hope its
> acceptable that I only change the SPI nodes to using the
> "labels style" in this attempt though?

Gregory and Thomas should give their O.K. for armada-* files. If you
need to change kirkwood-*, dove-* or orion5-* files, im happy with
label style.

      Andrew
