From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 22 Oct 2013 11:22:14 -0600
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131021170711.GA5256@netboy>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <20131021091555.GB21518@ulmo.nvidia.com>
 <20131021170711.GA5256@netboy>
Message-ID: <20131022172214.GF4061@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 07:07:11PM +0200, Richard Cochran wrote:
> On Mon, Oct 21, 2013 at 11:15:56AM +0200, Thierry Reding wrote:
> > 
> > Right now, we're taking away much of that flexibility and I see progress
> > on ARM actively hindered.
> 
> Baloney.
> 
> No one is taking away your flexibility or hindering progress. It is
> really very simple. Just make an arm-dt-devel tree where you can both
> change the bindings at will and recommend to people. Once bindings
> have seen some real world testing and have had time to mature, then
> request a merge into mainline.

The argument is that DT is a stable ABI we must never change it once
it hits mainline.

This leads to not accepting patches into mainline until they are
'stable'.

Whihc leads to vendors shipping code in real systems to real customers
with those out of tree patches. (Deadlines are a bitch)

The vendors are now forced to treat the DT as an *UNSTABLE* ABI
because they are shipping non-mainline DT schemas and plan to upgrade
to mainline someday.

Now the vendors no longer value DT as a stable ABI.

So, why are we making argument #1? Seems pretty self defeating to me.

Jason
