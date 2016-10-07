From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Oct 2016 12:09:32 +0900
Subject: [PATCH v3 04/11] ARM: dts: r8a7743: initial SoC device tree
In-Reply-To: <2883940.Oo8sg10L7m@wasted.cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
 <2883940.Oo8sg10L7m@wasted.cogentembedded.com>
Message-ID: <20161007030932.GH13721@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Oct 06, 2016 at 12:38:18AM +0300, Sergei Shtylyov wrote:
> The  initial R8A7743 SoC device tree including CPU cores, GIC, timer, SYSC,
> CPG, and the required clock descriptions.
> 
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I notice that this patch enables two CPUs. Have you tested SMP and:
- CPU hotplug
- Suspend to RAM
