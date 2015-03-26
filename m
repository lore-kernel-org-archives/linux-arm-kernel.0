From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Mar 2015 14:32:56 +0100
Subject: soc_id content according to specification
In-Reply-To: <9d1696d88282248ea76104d232119d05@agner.ch>
References: <9d1696d88282248ea76104d232119d05@agner.ch>
Message-ID: <20150326133256.GE31858@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 2014 March:
> 56a705a48eae ("ARM: mvebu: Add a SOC bus device entry")
> => 16-bit hexadecimal PCI-E device ID?

Just for clarification here. The PCE-E ID is the same as the SoC
model. So for example, the Kirkwood MV88f6281 has a PCI product id of
6281. The Armada XP mv88f78230 has a PCI product id of 8230.

      Andrew
