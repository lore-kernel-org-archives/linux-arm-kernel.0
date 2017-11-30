From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Nov 2017 11:09:11 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77970: use CPG core clock
 macros
In-Reply-To: <d904863e-e8c9-76ad-9d12-fd36ed68c3b4@cogentembedded.com>
References: <20171128202105.552196002@cogentembedded.com>
 <20171129095558.wvvcvfctwfmtrkq4@verge.net.au>
 <d904863e-e8c9-76ad-9d12-fd36ed68c3b4@cogentembedded.com>
Message-ID: <20171130100911.rdymtxswidey4bol@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 08:00:52PM +0300, Sergei Shtylyov wrote:
> On 11/29/2017 12:55 PM, Simon Horman wrote:
> 
> > > Now that the commit ecadea00f588 ("dt-bindings: clock: Add R8A77970 CPG
> > > core clock definitions") has hit Linus' tree, we  can replace the bare
> > > numbers (we had to use to avoid a cross tree dependency) with these macro
> > > definitions...
> > > 
> > > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > Thanks, applied.
> 
>    Not seeing these 2 patches in the today's devel branch tho...

Strange, I don't see them either.
I have queued them up (again?).
