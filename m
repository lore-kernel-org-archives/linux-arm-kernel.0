From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 May 2018 09:03:16 +0200
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: use CPG core clock
 macros
In-Reply-To: <0fa354d7-2403-1d41-49f0-1502912f5656@cogentembedded.com>
References: <ea6d3e8a-71a9-9998-f364-7dc82b97c2c0@cogentembedded.com>
 <0fa354d7-2403-1d41-49f0-1502912f5656@cogentembedded.com>
Message-ID: <20180502070315.gyxvbevjswtjojsc@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 01:43:56PM +0300, Sergei Shtylyov wrote:
> Now that the commit 35b3c462dae1 ("dt-bindings: clock: add R8A77980 CPG
> core clock definitions") has hit Linus' tree, we can replace the bare
> numbers (we had to use to avoid a cross tree dependency) with these macro
> definitions...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, applied.
