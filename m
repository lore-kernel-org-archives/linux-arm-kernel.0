From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Mar 2017 14:16:38 +0200
Subject: [PATCH] arm64: dts: r8a7795: salvator-x: Add current sense
 amplifiers
In-Reply-To: <1490694282-9439-1-git-send-email-geert+renesas@glider.be>
References: <1490694282-9439-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170328121633.GA20146@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 11:44:42AM +0200, Geert Uytterhoeven wrote:
> Add device nodes for two Maxim max961x current sense amplifiers
> sensing the VDD_0.8V and DVFS_0.8V lines.
> 
> Based on a patch for r8a7796-salvator-x.dts by Jacopo Mondi.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Pending acceptance of the maxim,max9611 DT bindings.

I have marked this as deferred accordingly.
