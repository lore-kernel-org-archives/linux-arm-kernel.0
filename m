From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Nov 2017 10:55:59 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77970: use CPG core clock
 macros
In-Reply-To: <20171128202105.552196002@cogentembedded.com>
References: <20171128202105.552196002@cogentembedded.com>
Message-ID: <20171129095558.wvvcvfctwfmtrkq4@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 11:15:44PM +0300, Sergei Shtylyov wrote:
> Now that the commit ecadea00f588 ("dt-bindings: clock: Add R8A77970 CPG
> core clock definitions") has hit Linus' tree, we  can replace the bare
> numbers (we had to use to avoid a cross tree dependency) with these macro
> definitions...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, applied.
