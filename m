From: chripell@gmail.com (christian pellegrin)
Date: Sat, 19 Dec 2009 12:24:15 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091218215713.GL5527@n2100.arm.linux.org.uk>
References: <cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
	<20091215171440.GA15855@n2100.arm.linux.org.uk>
	<cabda6420912160835k714b9de4m7c647da97055f91b@mail.gmail.com>
	<cabda6420912160938m6ea11da5t947c2bf082c430b7@mail.gmail.com>
	<alpine.LFD.2.00.0912181517120.28241@xanadu.home>
	<20091218204455.GK5527@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912181556270.28241@xanadu.home>
	<20091218215713.GL5527@n2100.arm.linux.org.uk>
Message-ID: <cabda6420912190324s1e2c7864tadd5aca9aacc640e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 10:57 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 18, 2009 at 04:23:30PM -0500, Nicolas Pitre wrote:
>> That's a valid concern. ?In which case I'd suggest that Christian waits
>> until your changes are visible somewhere for him to rebase his patch on
>> top and retest it before reposting. ?The current patch (with my
>> suggested modification) might be worth considering for linux-stable
>> nevertheless.
>
> It'll be a while before my patches are ready - they touch every other
> architecture in the kernel because we need access to the kmapped page
> table to modify the PTE...
>
> http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/umc
>
> GIT:
> http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git umc
>

I'm going to send a proper patch (at least for checkpatch.pl
standards) in response to this mail in case someone cares to add it to
theirs trees. I'm cloning the mentioned git repository and will try to
do some testing on umc branch.The modifications seem important so one
more tester won't hurt I guess.


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
