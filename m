From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Apr 2014 18:08:24 +0200
Subject: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375 DB
 board
In-Reply-To: <20140416180315.5153c3f7@skate>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <534EA8C9.7010907@gmail.com> <20140416180315.5153c3f7@skate>
Message-ID: <20140416160824.GA14842@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> For minor differences such as SoC stepping, I personally prefer to not
> have separate Device Trees. We already have many of them, for each
> variant of the various SOCs. If we add the different steppings, it's
> going to be even more complicated. Also, there will be a new iteration
> of the Armada 375 DB with an A0 chip, which does not have the Z1 bug.

How many Z1 are there out and about? Would it be simpler to just
disable thermal on Z1? If only development boards have Z1, this could
be reasonable.

	Andrew
