From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Jan 2017 10:01:53 +0100
Subject: [PATCH] arm64: dts: r8a7795: Add missing power-domains property
 for sata
In-Reply-To: <1484585873-30075-1-git-send-email-geert+renesas@glider.be>
References: <1484585873-30075-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170117090152.GB7960@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 05:57:53PM +0100, Geert Uytterhoeven wrote:
> This went unnoticed as the sata_rcar driver doesn't support Runtime PM
> yet, but manages module clocks manually.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.11.
