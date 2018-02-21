From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Feb 2018 18:26:08 +0100
Subject: [PATCH v2 16/19] ARM64: dts: r8a77965: Add GPIO nodes
In-Reply-To: <1519139541-18783-17-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-17-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180221172608.73lw32zsnqtrnxcn@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 04:12:18PM +0100, Jacopo Mondi wrote:
> Add GPIO nodes to r8a77965 SoC device tree file.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> v1 -> v2:
> - Replace ALWAYS_ON power area define with numeric constant
> - Do not move gpio nodes

Thanks, applied with prefix updated to:

arm64: dts: renesas: r8a77965:
