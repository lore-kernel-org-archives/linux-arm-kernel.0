From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Mar 2014 10:05:18 +0100
Subject: [PATCH 0/2] ARM: mvebu: add a clock for mdio nodes on Armada
 370/38x/XP
In-Reply-To: <1395790439-21332-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395790439-21332-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140326090518.GB25349@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 12:33:57AM +0100, Thomas Petazzoni wrote:
> Jason, Andrew, Gregory, Sebastian,
> 
> Here is a set of two patches that add a clock specification to the
> mdio node on Armada 370/XP and Armada 38x. This allows the mvmdio
> driver to work properly when loaded as a module, before mvneta is
> loaded.
> 
> I've separated the Armada 370/XP and Armada 38x fixes in two patches,
> because the Armada 370/XP fix should be pushed to stable, while the
> Armada 38x does not need to be pushed to stable since Armada 38x
> support only appears in 3.15.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
