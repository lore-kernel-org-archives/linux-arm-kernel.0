From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Jul 2012 15:33:10 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <20120705152840.2aea94cf@skate>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
 <20120705145801.4985770d@skate> <20120705131522.GW17534@lunn.ch>
 <20120705152840.2aea94cf@skate>
Message-ID: <20120705133310.GY17534@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I guess I'll just stick to irq_chip_generic + irqdomain_legacy for now.

Hi Thomas

That is what my patch currently does. Feel free to re-use parts of the
orion code.

      Andrew
