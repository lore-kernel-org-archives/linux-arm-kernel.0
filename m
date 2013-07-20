From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jul 2013 21:45:59 +0200
Subject: [RESEND PATCH v7 00/22] MBus DT binding: The return of PCIe
In-Reply-To: <20130720185443.GB21460@localhost>
References: <1373900271-4722-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130720165855.GB26625@lunn.ch> <20130720173847.GC26625@lunn.ch>
 <20130720185443.GB21460@localhost>
Message-ID: <20130720194559.GA27517@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The patchset works only for Armada 370 and Armada XP SoC, not for Kirkwood.
> For some reason I was completely sure there wasn't any DT-enabled Kirkwood
> boards with PCIe support.

I had a quick look at Dove and Orion5x. It looks like there are none
with PCIe support. So only Kirkwood is broken.

	Andrew
