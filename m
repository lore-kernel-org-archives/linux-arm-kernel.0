From: horms@verge.net.au (Simon Horman)
Date: Mon, 3 Apr 2017 06:33:51 -0400
Subject: [PATCH 0/3] ARM: dts: rcar-gen2: Correct parent of SSI[0-9] clocks
In-Reply-To: <1491212743-6911-1-git-send-email-geert+renesas@glider.be>
References: <1491212743-6911-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170403103350.GH31988@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:45:40AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus, Morimoto-san,
> 
> The SSI-ALL gate clock is located in between the P clock and the
> individual SSI[0-9] clocks, hence the former should be listed as their
> parent.
> 
> This patch series corrects the parents in the DTSes r8a7790, r8a7791,
> and r8a7793.  The DTS for r8a7794, and the CPG/MSSR-based clock drivers
> for r8a7743, r8a7745, and r8a7795 already describe the correct parent.
> 
> Thanks!

Thanks, I have queued these up.
