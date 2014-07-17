From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Jul 2014 15:28:03 +0100
Subject: [PATCHv4 0/5] arm64: handle heterogeneous system register values
In-Reply-To: <20140717142133.GO30313@leverpostej>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
 <20140717110332.GE18203@arm.com>
 <20140717142133.GO30313@leverpostej>
Message-ID: <20140717142803.GN21153@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 03:21:33PM +0100, Mark Rutland wrote:
> On Thu, Jul 17, 2014 at 12:03:33PM +0100, Catalin Marinas wrote:
> > On Wed, Jul 16, 2014 at 04:32:42PM +0100, Mark Rutland wrote:
> > > Mark Rutland (5):
> > >   arm64: add MIDR_EL1 field accessors
> > >   arm64: cpuinfo: record cpu system register values
> > >   arm64: cachetype: report weakest cache policy
> > >   arm64: add runtime system sanity checks
> > 
> > For these 4 patches:
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thanks.
> 
> I take it you'll pick these up directly and apply the tags from you and
> Will?
> 
> Or would you prefer I place these in a branch?

We'll grab them later today, I expect. If testing explodes, I'll let you
know ;)

Will
