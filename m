From: horms@verge.net.au (Simon Horman)
Date: Mon, 14 May 2018 16:30:33 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77990: Add GPIO device nodes
In-Reply-To: <e9646f33-9a82-f3ea-c4a6-cd2469b7658a@cogentembedded.com>
References: <20180513090855.25982-1-horms+renesas@verge.net.au>
 <e9646f33-9a82-f3ea-c4a6-cd2469b7658a@cogentembedded.com>
Message-ID: <20180514143032.fxk4gcww6xihilrl@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 12:12:27PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 5/13/2018 12:08 PM, Simon Horman wrote:
> 
> > The compat string renesas,gpio-rcar has been deprecated since v4.14,
> > the same release that r8a77990 SoC support was added. Thus
> > renesas,gpio-rcar can safely be removed without any risk of behaviour
> > changes between old and new mainline kernels and DTBs.
> 
>    This hardly matches the subject. :-)

Indeed, I will resubmit.

> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> [...]
> 
> MBR, Sergei
> 
