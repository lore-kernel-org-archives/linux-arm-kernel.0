From: horms@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 15:18:13 +0100
Subject: [PATCH 0/2] ARM: dts: r8a7743/r8a7745: Move RST nodes before
 SYSC nodes
In-Reply-To: <1479464663-19054-1-git-send-email-geert+renesas@glider.be>
References: <1479464663-19054-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20161123141812.GB9057@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 11:24:21AM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series moves the RST nodes in the recently added RZ/G DTS
> files before the SYSC nodes, to preserve both alphabetical (label) and
> numerical ordering (unit address).
> 
> Thanks for applying!

Thanks, I have queued these up for v4.11.
