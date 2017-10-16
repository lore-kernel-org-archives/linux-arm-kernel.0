From: horms@verge.net.au (Simon Horman)
Date: Mon, 16 Oct 2017 11:42:17 +0200
Subject: [PATCH 07/13] ARM: dts: r8a7790: Add missing clocks for
 secondary CA15 CPU cores
In-Reply-To: <1507800916-11509-8-git-send-email-geert+renesas@glider.be>
References: <1507800916-11509-1-git-send-email-geert+renesas@glider.be>
 <1507800916-11509-8-git-send-email-geert+renesas@glider.be>
Message-ID: <20171016094209.2rnsdgye2dfx7dol@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 11:35:10AM +0200, Geert Uytterhoeven wrote:
> Currently only the primary CPU in the CA15 cluster has a clocks
> property, while the secondary CPU cores are driven by the same clock.
> Add the missing clocks properties to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Simon Horman <horms+renesas@verge.net.au>
