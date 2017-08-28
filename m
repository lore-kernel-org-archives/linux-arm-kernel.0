From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Aug 2017 17:51:35 +0200
Subject: [RFC] ARM: Orion: Check DRAM window size
In-Reply-To: <20170828153039.27088-1-jlu@pengutronix.de>
References: <20170828152517.24506-1-jlu@pengutronix.de>
 <20170828153039.27088-1-jlu@pengutronix.de>
Message-ID: <20170828155135.GF10418@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 05:30:39PM +0200, Jan Luebbe wrote:
> This is a corresponding change as "PCI: mvebu: Check DRAM window size" applied
> to the Orion PCIe driver. I don't have the relevant hardware myself, but the
> patch may still be useful for someone who has. This is completely untested.

Hi Jan

I've never seen one of these boards have more than 512M bytes of RAM.
So it is probably a non-issue.

   Andrew
