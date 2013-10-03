From: horms@verge.net.au (Simon Horman)
Date: Fri, 4 Oct 2013 08:57:33 +0900
Subject: [PATCH 01/05] ARM: shmobile: Sync KZM9D DTS with KZM9D reference
 DTS
In-Reply-To: <2066391.GX4ZAHlWrz@avalon>
References: <20131001103255.813.65710.sendpatchset@w520>
 <20131001103305.813.70296.sendpatchset@w520>
 <20131003034947.GH28463@verge.net.au> <2066391.GX4ZAHlWrz@avalon>
Message-ID: <20131003235733.GC29457@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 11:56:40AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 03 October 2013 12:49:48 Simon Horman wrote:
> > On Tue, Oct 01, 2013 at 07:33:05PM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@opensource.se>
> > > 
> > > Copy the device nodes from KZM9D reference into the KZM9D
> > > device tree file. This will allow us to use a single DTS
> > > file regarless of kernel configuration. In case of legacy
> > > C board code the device nodes may or may not be used, but
> > > in the multiplatform case all the DT device nodes are used.
> > > 
> > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > > ---
> > > 
> > >  arch/arm/boot/dts/emev2-kzm9d.dts |   33 +++++++++++++++++++++++++++++++-
> > >  1 file changed, 32 insertions(+), 1 deletion(-)
> > 
> > Thanks, I have queued this up in the dt3 branch.
> 
> Splitting the series across two branches would result in bisection breakages 
> I'm afraid. Would it be an issue to queue all patches to a single branch ?

Sure, I will re-arrange things accordingly.
