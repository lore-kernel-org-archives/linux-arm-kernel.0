From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 May 2017 16:49:03 +0200
Subject: [PATCH 02/13] ARM: dts: armada-385-linksys: label nodes
In-Reply-To: <20170521124903.11050-3-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-3-ralph.sennhauser@gmail.com>
Message-ID: <20170522144903.GH29447@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 02:48:51PM +0200, Ralph Sennhauser wrote:
> Add labels to nodes used by dependants. Also rename node gpio_keys to
> gpio-keys to mach the style of the rest of the file as well as the

s/mach/match

> documented example.
> 
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
