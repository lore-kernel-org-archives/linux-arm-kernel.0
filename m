From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Aug 2015 10:26:52 +0900
Subject: [PATCH v2] ARM: shmobile: silk: add SDHI1 DT support
In-Reply-To: <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
Message-ID: <20150812012652.GH15957@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Aug 11, 2015 at 01:44:03AM +0300, Sergei Shtylyov wrote:
> Define the SILK board dependent part of the SDHI1 (connected to micro-SD slot)
> device nodes along with the necessary voltage regulators.
> 
> Based on the original patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against 'renesas-devel-20150810-v4.2-rc6' tag of Simon Horman's
> 'renesas.git' repo plus the R8A7794/SILK QSPI patches just re-posted. It needs
> the R8A7794 GPIO patches in order to compile.
> 
> Changes in version 2:
> - removed not working SDHI0 stuff, renamed the patch;
> - replaced SDHI1's "wp-gpios" property with "disable-wp".

I am wondering if you could explain the motivation for the "disable-wp"
update and weather it is appropriate for other r8a779* dts files.

Thanks.
