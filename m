From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 Nov 2016 13:57:23 +0100
Subject: [PATCH] cpufreq: dt: Add support for r8a7743 and r8a7745
In-Reply-To: <1479290751-9705-1-git-send-email-geert+renesas@glider.be>
References: <1479290751-9705-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20161116125723.GC3039@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 11:05:51AM +0100, Geert Uytterhoeven wrote:
> Add the compatible strings for supporting the generic cpufreq driver on
> the Renesas RZ/G1M (r8a7743) and RZ/G1E (r8a7745) SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Support for RZ/G1M and RZ/G1E is expected to land in v4.10.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
