From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 May 2017 14:15:14 +0200
Subject: [PATCH 12/13] clk: mvebu: add support for 1866MHz variants
In-Reply-To: <20170521124903.11050-13-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-13-ralph.sennhauser@gmail.com>
Message-ID: <20170523121514.GS13759@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 02:49:01PM +0200, Ralph Sennhauser wrote:
> The Linksys WRT3200ACM CPU is clocked at 1866MHz. Add 1866MHz to
> the list of supported CPU frequencies.
> 
> Noticed by the following warning:
> [    0.000000] Selected CPU frequency (16) unsupported

Are the L2 and DDR clocks using sensible values?

    Andrew
