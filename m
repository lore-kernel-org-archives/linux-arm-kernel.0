From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Apr 2017 10:58:33 -0400
Subject: [PATCH] arm64: dts: r8a7795-salvator-x: Update memory node to 4
 GiB map
In-Reply-To: <1491485487-2006-1-git-send-email-geert+renesas@glider.be>
References: <1491485487-2006-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170407145832.GB1278@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 03:31:27PM +0200, Geert Uytterhoeven wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch addes memory region:
> 
>   - After changes, the Salvator-X board has the following map:
>     Bank0: 1GiB RAM : 0x000048000000 -> 0x0007fffffff
>     Bank1: 1GiB RAM : 0x000500000000 -> 0x0053fffffff
>     Bank2: 1GiB RAM : 0x000600000000 -> 0x0063fffffff
>     Bank3: 1GiB RAM : 0x000700000000 -> 0x0073fffffff
> 
>   - Before changes, the old map looked like this:
>     Bank0: 1GiB RAM : 0x000048000000 -> 0x0007fffffff
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This patch is looooong overdue.

Thanks, I have queued this up for v4.13.
