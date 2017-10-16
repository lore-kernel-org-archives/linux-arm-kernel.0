From: horms@verge.net.au (Simon Horman)
Date: Mon, 16 Oct 2017 11:42:35 +0200
Subject: [PATCH 08/13] ARM: dts: r8a7790: Add clocks for CA7 CPU cores
In-Reply-To: <1507800916-11509-9-git-send-email-geert+renesas@glider.be>
References: <1507800916-11509-1-git-send-email-geert+renesas@glider.be>
 <1507800916-11509-9-git-send-email-geert+renesas@glider.be>
Message-ID: <20171016094234.i3jzpo6nern3h6nr@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 11:35:11AM +0200, Geert Uytterhoeven wrote:
> Currently only the CPU cores in the CA15 cluster have clocks properties.
> Add the missing clocks properties for the CPU cores in the CA7 cluster
> to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Simon Horman <horms+renesas@verge.net.au>
