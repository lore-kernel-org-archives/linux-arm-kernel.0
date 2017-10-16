From: horms@verge.net.au (Simon Horman)
Date: Mon, 16 Oct 2017 09:09:10 +0200
Subject: [PATCH/RFC 5/5] arm64: dts: renesas: salvator-common: Configure
 PMIC for DDR Backup Power
In-Reply-To: <1507649178-31473-6-git-send-email-geert+renesas@glider.be>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20171016070909.vwg5x6wntqgvtdr5@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 05:26:18PM +0200, Geert Uytterhoeven wrote:
> On Salvator-X(S), all of DDR0, DDR1, DDR0C, and DDR1C need to be kept
> powered when backup mode is enabled.
> 
> Reflect this in the rohm,ddr-backup-power property for the BD9571MWV
> PMIC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Hi,

I have marked this as deferred pending acceptance of the bindings.
Please repost or otherwise ping me once that dependency is in place.
