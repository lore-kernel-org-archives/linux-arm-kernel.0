From: horms@verge.net.au (Simon Horman)
Date: Fri, 20 Feb 2015 15:52:16 -0500
Subject: [PATCH] ARM: shmobile: r8a7790: add ADSP clocks
In-Reply-To: <54E79337.9090500@cogentembedded.com>
References: <1909663.BCLINDXhVH@wasted.cogentembedded.com>
 <54E79337.9090500@cogentembedded.com>
Message-ID: <20150220205216.GE20237@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 11:04:07PM +0300, Sergei Shtylyov wrote:
> On 12/30/2014 11:21 PM, Sergei Shtylyov wrote:
> 
> >Add the ADSP clocks to the CPG and MSTP5 nodes of the R8A7790 device tree.
> 
> >Based on the original patch by Konstantin Kozhevnikov
> ><konstantin.kozhevnikov@cogentembedded.com>.
> 
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >---
> >The patch is against 'renesas-devel-20141229-v3.19-rc2' tag of Simon Horman's
> >'renesas.git' repo plus the R8A7790 CAN patches posted earlier. It depends on
> >the patch adding the ADSP clock support to the 'clk-rcar-gen2' driver in order
> >to work.
> 
>    Simon, please consider merging this patch as well.

Thanks done.

I plan to do a push of renesas-devel shortly.
Please let me know if you have anything else that I should wait for.
