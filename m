From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 May 2017 14:06:33 +0200
Subject: [PATCH 10/13] ARM: dts: armada-385-linksys: group pins in pinctrl
In-Reply-To: <20170521124903.11050-11-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-11-ralph.sennhauser@gmail.com>
Message-ID: <20170523120633.GQ13759@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 02:48:59PM +0200, Ralph Sennhauser wrote:
> A pin group per node is sufficient, further specialisation only serves
> as documentation which can be a comment just as well. This simplifies
> configuring pins for nodes in dependants.
> 
> Also use labels which end up right by the node they are intended for.
> 
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
