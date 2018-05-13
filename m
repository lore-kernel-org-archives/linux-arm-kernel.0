From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 13 May 2018 12:12:27 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77990: Add GPIO device nodes
In-Reply-To: <20180513090855.25982-1-horms+renesas@verge.net.au>
References: <20180513090855.25982-1-horms+renesas@verge.net.au>
Message-ID: <e9646f33-9a82-f3ea-c4a6-cd2469b7658a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 5/13/2018 12:08 PM, Simon Horman wrote:

> The compat string renesas,gpio-rcar has been deprecated since v4.14,
> the same release that r8a77990 SoC support was added. Thus
> renesas,gpio-rcar can safely be removed without any risk of behaviour
> changes between old and new mainline kernels and DTBs.

    This hardly matches the subject. :-)

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei
