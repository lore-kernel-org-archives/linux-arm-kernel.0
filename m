From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 08:21:56 +0100
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <alpine.LFD.2.00.1109262047290.2718@xanadu.home>
References: <alpine.LFD.2.00.1109260952490.2718@xanadu.home>
	<alpine.LFD.2.00.1109261023360.2718@xanadu.home>
	<20110926191055.GP22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261514330.2718@xanadu.home>
	<alpine.LFD.2.00.1109261606210.2718@xanadu.home>
	<20110926223839.GB23680@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261901550.2718@xanadu.home>
	<20110926232943.GD23680@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109262028310.2718@xanadu.home>
	<alpine.LFD.2.00.1109262047290.2718@xanadu.home>
Message-ID: <20110927072156.GQ22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 08:52:48PM -0400, Nicolas Pitre wrote:
> On Mon, 26 Sep 2011, Nicolas Pitre wrote:
> 
> > On Tue, 27 Sep 2011, Russell King - ARM Linux wrote:
> > 
> > > A little more discipline and communication (such as asking me to drop
> > > the duplicate commit _first_) would be nice.
> > 
> > Certainly.  Improving communication both ways might help.
> 
> One way this could be improved would be for your patch system to send 
> notification emails with the submitter address explicit in the To: 
> field.  Right now it contains linux-arm-patches at lists.arm.linux.org.uk 
> only, therefore those emails don't get sorted with the best priority 
> they could get.

Stop splitting hairs.

The fact of the matter is that you should have said in the final pull
request that you'd also sent one of the patches to the patch system
_whether_ _or_ _not_ it was applied.  Whether it was applied or not
is completely irrelevant - because either way it requires some action
(either to remove it from my git tree if applied _OR_ discard it from
the patch system if not.)

The fact you didn't mention it in the final pull request at all is the
problem.
