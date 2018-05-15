From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 May 2018 09:14:35 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77990: Add GPIO device nodes
In-Reply-To: <d232d79b-2d95-9938-bc1c-55b705c455c8@cogentembedded.com>
References: <20180513090855.25982-1-horms+renesas@verge.net.au>
 <e9646f33-9a82-f3ea-c4a6-cd2469b7658a@cogentembedded.com>
 <20180514143032.fxk4gcww6xihilrl@verge.net.au>
 <d232d79b-2d95-9938-bc1c-55b705c455c8@cogentembedded.com>
Message-ID: <20180515071435.46roul4zciy4llrk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 06:57:04PM +0300, Sergei Shtylyov wrote:
> On 05/14/2018 05:30 PM, Simon Horman wrote:
> 
> >>> The compat string renesas,gpio-rcar has been deprecated since v4.14,
> >>> the same release that r8a77990 SoC support was added. Thus
> >>> renesas,gpio-rcar can safely be removed without any risk of behaviour
> >>> changes between old and new mainline kernels and DTBs.
> >>
> >>    This hardly matches the subject. :-)
> > 
> > Indeed, I will resubmit.
> 
>    I'm seeing this patch merged on Sunday...

Yes, I saw that too. I dropped it yesterday.
