From: horms@verge.net.au (Simon Horman)
Date: Mon, 3 Apr 2017 06:35:23 -0400
Subject: [PATCH] ARM: dts: koelsch: Correct clock frequency of X2 DU
 clock input
In-Reply-To: <1491213319-7668-1-git-send-email-geert+renesas@glider.be>
References: <1491213319-7668-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170403103522.GK31988@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:55:19AM +0200, Geert Uytterhoeven wrote:
> The X2 crystal oscillator on the Koelsch development board provides a
> 74.25 MHz clock, not a 148.5 MHz clock.
> 
> Fixes: cd21cb46e14aae3a ("ARM: shmobile: koelsch: Add DU external pixel clocks to DT")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Confirmed by schematics, user manual, and physical inspection of 2
> Koelsch instances (my scope has not enough bandwidth to measure the
> actual frequency).
> 
> Probably this was copied from r8a7790-lager.dts, as Lager does have two
> identical crystal oscillators X2 and X13.
> 
> Note that X2 is socketed, so it can be changed.

Thanks, I have queued this up.
