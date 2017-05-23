From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 May 2017 14:04:38 +0200
Subject: [PATCH 09/13] ARM: dts: armada-385-linksys: partition layout is
 board specific
In-Reply-To: <20170521124903.11050-10-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-10-ralph.sennhauser@gmail.com>
Message-ID: <20170523120438.GP13759@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 02:48:58PM +0200, Ralph Sennhauser wrote:
> Move the partition layout to individual boards. The Linksys WRT 3200 ACM
> (Rango) comes with a 256MiB nand flash chip and different layout.
> 
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

This is a reasonable way to do it, given the differences.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
