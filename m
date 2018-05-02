From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 May 2018 09:03:26 +0200
Subject: [PATCH 2/2] arm64: dts: renesas: r8a77980: use SYSC power domain
 macros
In-Reply-To: <df17ca8f-7942-3cdb-04d5-5d73e0259be5@cogentembedded.com>
References: <ea6d3e8a-71a9-9998-f364-7dc82b97c2c0@cogentembedded.com>
 <df17ca8f-7942-3cdb-04d5-5d73e0259be5@cogentembedded.com>
Message-ID: <20180502070326.h52wsmbexs4p3z44@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 01:45:21PM +0300, Sergei Shtylyov wrote:
> Now that the commit 7755b40d07a8 ("dt-bindings: power: add R8A77980 SYSC
> power domain definitions") has hit Linus' tree, we can replace  the bare
> numbers (we had to use to avoid a cross tree dependency) with these macro
> definitions...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, applied.
