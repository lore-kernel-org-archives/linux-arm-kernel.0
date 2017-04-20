From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Apr 2017 18:10:19 +0900
Subject: [PATCH v2] arm64: dts: r8a7795: salvator-x: Add current sense
 amplifiers
In-Reply-To: <1492591057-10674-1-git-send-email-geert+renesas@glider.be>
References: <1492590950-10534-1-git-send-email-geert+renesas@glider.be>
 <1492591057-10674-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170420091018.GK3760@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 10:37:37AM +0200, Geert Uytterhoeven wrote:
> Add device nodes for two Maxim max961x current sense amplifiers
> sensing the VDD_0.8V and DVFS_0.8V lines.
> 
> Based on a patch for r8a7796-salvator-x.dts by Jacopo Mondi.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Bindings and driver are now in staging-next.

Forgive my ignorance, what is the flow of changes from staging-next
to a release?
