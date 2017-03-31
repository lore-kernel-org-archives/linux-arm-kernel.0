From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Mar 2017 17:35:49 +0200
Subject: [PATCH] ARM: dts: armada-385-linksys: disk-activity trigger for
 all
In-Reply-To: <20170330165405.14540-1-ralph.sennhauser@gmail.com>
References: <20170330165405.14540-1-ralph.sennhauser@gmail.com>
Message-ID: <20170331153549.GA12814@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 06:54:04PM +0200, Ralph Sennhauser wrote:
> Commit a4ee7e18d808 ("ARM: dts: armada: Add default trigger for sata
> led") adds the default trigger to individual boards, move it to
> armada-385-linksys.dtsi which effectively enables the definition for
> the WRT1900ACS (Shelby) as well as for future boards.
> 
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Centralising this makes sense.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
