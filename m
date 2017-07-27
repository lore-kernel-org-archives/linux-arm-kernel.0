From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Jul 2017 17:25:23 +0200
Subject: [PATCH] ARM: shmobile: rcar-gen2: Correct arch timer frequency
 on RZ/G1E
In-Reply-To: <1500384557-22123-1-git-send-email-geert+renesas@glider.be>
References: <1500384557-22123-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170727152523.GK16143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 03:29:17PM +0200, Geert Uytterhoeven wrote:
> According to the datasheet, the frequency of the ARM architecture timer
> on RZ/G1E depends on the frequency of the ZS clock, just like on R-Car
> E2 and V2H.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested due to lack of hardware.
> 
> v2:
>   - Rebased to avoid dependencies.

Thanks. I have applied this for v4.14.
