From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 May 2018 15:20:26 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77995: don't use deprecated
 renesas,gpio-rcar
In-Reply-To: <20180514143543.16590-1-horms+renesas@verge.net.au>
References: <20180514143543.16590-1-horms+renesas@verge.net.au>
Message-ID: <20180522132026.flzd5jjh5chqotzm@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 04:35:43PM +0200, Simon Horman wrote:
> The compat string renesas,gpio-rcar has been deprecated since v4.14,
> the same release that r8a77990 SoC support was added. Thus
> renesas,gpio-rcar can safely be removed without any risk of behaviour
> changes between old and new mainline kernels and DTBs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied
