From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2011 21:14:46 +0000
Subject: [PATCH] ARM: futex: fix clobbering oldval
In-Reply-To: <1323200328.11696.32.camel@constitution.bos.jonmasters.org>
References: <1316660015.6872.1.camel@puffmine-laptop>
 <20110922172653.GH13572@e102144-lin.cambridge.arm.com>
 <1323197914.11696.30.camel@constitution.bos.jonmasters.org>
 <20111206191109.GB5385@mudshark.cambridge.arm.com>
 <1323200328.11696.32.camel@constitution.bos.jonmasters.org>
Message-ID: <20111206211446.GB15640@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 07:38:48PM +0000, Jon Masters wrote:
> On Tue, 2011-12-06 at 19:11 +0000, Will Deacon wrote:
> > On Tue, Dec 06, 2011 at 06:58:34PM +0000, Jon Masters wrote:
> > > 
> > > Was there ever any additional followup on this topic?
> > 
> > Yup, check commit df77abca ("ARM: 7099/1: futex: preserve oldval in SMP
> > __futex_atomic_op"). It should be in stable for all affected kernels too.
> 
> Yea, Mark flagged that patch and it was included into the kernels on our
> boards here. So far, it seems to be making some improvement, though we
> still have stuck boards and weird signal issues sometimes. We are trying
> to collect more data when this occurs (I gave the engineer concerned
> some instructions around collecting data that will be of use). So I just
> wondered if you saw any more futex issues, or if this is believe fixed.

I think this is fixed, but that doesn't mean there aren't bugs lurking
elsewhere that I'm simply not seeing. If you do get any diagnostics or
concrete debug information, please CC me on any posts to the list.

Cheers,

Will
