From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Jun 2013 23:09:05 +0900
Subject: [PATCH v3] ARM: shmobile: BOCK-W: add Ether support
In-Reply-To: <201306020240.55702.sergei.shtylyov@cogentembedded.com>
References: <201306020240.55702.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130612140905.GM32751@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 02:40:55AM +0400, Sergei Shtylyov wrote:
> Register Ether device from bockw_init(), passing the platform data to it, adding
> only the RMII pin group to bockw_pinctrl_map[].  Although the LINK signal exists
> on the board, it's connected to the link/activity LED  output of the PHY, thus
> the link disappears and reappears after each packet. We'd be better off ignoring
> such signal and getting the link state from the PHY indirectly.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is atop of Simon's 'renesas.git' repo, 'renesas-next-20130528' tag
> and the USB patches just reposted. I decided to move it ahead of the VIN patches
> as it can be merged right now since all dependecies have been already met.

Thanks, queued up in the boards branch.
