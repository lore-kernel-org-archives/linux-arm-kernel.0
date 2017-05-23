From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 May 2017 14:07:07 +0200
Subject: [PATCH 11/13] ARM: dts: armada-385-linksys: fixup button node
 names
In-Reply-To: <20170521124903.11050-12-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-12-ralph.sennhauser@gmail.com>
Message-ID: <20170523120707.GR13759@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 02:49:00PM +0200, Ralph Sennhauser wrote:
> Buttons don't have a reg property; drop pseudo address and fixup names
> of individual button nodes. Also drop #address-cells and #size-cells
> properties.
> 
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
