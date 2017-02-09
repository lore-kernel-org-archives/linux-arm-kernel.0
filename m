From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Feb 2017 16:51:55 +0100
Subject: [PATCH] ARM: dts: armada-385-linksys: fix DSA compatible property
In-Reply-To: <20170209152702.23036-1-ralph.sennhauser@gmail.com>
References: <20170209152702.23036-1-ralph.sennhauser@gmail.com>
Message-ID: <20170209155155.GA29882@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 04:27:02PM +0100, Ralph Sennhauser wrote:
> The switch to the new DSA binding used "marvell,mv88e6095" for the
> compatible property which doesn't exist, use "marvell,mv88e6085"
> instead.
> 
> Fixes: 455b82f03f52 ("ARM: dts: armada-385-linksys: Utilize new DSA binding")
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Hi Ralph

Good catch.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Gregory, this is in the mvebu dt branch and need fixing there.

[Goes away to look at the other dts files]

O.K. Florian only made this typ0 once in the patchset.

     Andrew
