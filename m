From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Dec 2014 09:23:53 +0900
Subject: [PATCH] ARM: shmobile: r8a7790: add MLB+ clock
In-Reply-To: <54989071.2060509@cogentembedded.com>
References: <2277336.BnuIY8UiP8@wasted.cogentembedded.com>
 <20141222000610.GG29188@verge.net.au>
 <54989071.2060509@cogentembedded.com>
Message-ID: <20141223002353.GD2817@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Dec 23, 2014 at 12:43:13AM +0300, Sergei Shtylyov wrote:
> On 12/22/2014 03:06 AM, Simon Horman wrote:
> 
> >>From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> 
> >>Add MLB+ clock to R8A7790 device tree.
> 
> >>Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> >>[Sergei: rebased, renamed, added changelog]
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>---
> >>This patch is against 'renesas-devel-20141218-v3.18' tag of Simon Horman's
> >>'renesas.git' repo.
> 
> >Thanks, I have queued this up.
> 
>    Oops, just saw a formatting issue in this patch...
> 
> [...]
> >>Index: renesas/include/dt-bindings/clock/r8a7790-clock.h
> >>===================================================================
> >>--- renesas.orig/include/dt-bindings/clock/r8a7790-clock.h
> >>+++ renesas/include/dt-bindings/clock/r8a7790-clock.h
> >>@@ -97,6 +97,7 @@
> >>  #define R8A7790_CLK_LVDS0		26
> >>
> >>  /* MSTP8 */
> >>+#define R8A7790_CLK_MLB		2
> 
>    Need one more tab here.
> 
> >>  #define R8A7790_CLK_VIN3		8
> >>  #define R8A7790_CLK_VIN2		9
> >>  #define R8A7790_CLK_VIN1		10
> 
>    Perhaps you still can fix it up, or I can resend? I'm not seeing this
> patch in the 'devel' branch yet...

Thanks for following up on this.

I had the patch queued up locally but it seems that I forgot to push them.

I have fixed up this patch by adding an extra tab and pushed the result.
The result should be in renesas-devel-20141223-v3.19-rc1
(But kernel.org seems slow today).

Please let me know if I messed things up somehow.
