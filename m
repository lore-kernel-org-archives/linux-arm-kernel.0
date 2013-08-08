From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 8 Aug 2013 09:12:06 +0200
Subject: [PATCH 0/5] Armada 370/XP clocksource fixes
In-Reply-To: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130808071206.GA29815@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 08:52:31PM -0300, Ezequiel Garcia wrote:
> This small patchset fixes a somewhat minor issue found in the clocksource
> driver for Armada 370/XP SoC.
> 
> The Armada 370 SoC has no 25 MHz fixed timer, while the Armada XP SoC cannot
> work properly without such 25 MHz fixed timer selected.

Hi Ezequiel

Is the XP case a silicon bug, or a design feature? If its a silicon
bug, is it likely to be fixed in later steppings of the SOCs? If this
feature is to come back, might we want to keep the property?

	Andrew
