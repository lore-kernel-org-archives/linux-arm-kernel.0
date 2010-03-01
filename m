From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 1 Mar 2010 21:23:37 +0800
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <alpine.LFD.2.00.1002281928200.10679@xanadu.home>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002281928200.10679@xanadu.home>
Message-ID: <f17812d71003010523r6aa7cfd0va28b994dfadedeac@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 1, 2010 at 8:42 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 28 Feb 2010, Russell King - ARM Linux wrote:
>
>> You've destroyed your original commits, so this calls into question my
>> entire 'devel-stable' branch.
>>
>> I've still not decided what to do about this. ?I'll ask Linus to merge
>> most of the 'devel' stuff without 'devel-stable' merged into mainline
>> to move stuff forward - this means _no_ _one's_ git work will be merged
>> through my tree, at least initially.
>>
>> However, I'm putting 'devel-stable' on hold; I'll let the other ARM git
>> maintainers discuss this and work out what they're going to do about
>> this mess. ?One solution is to destroy the 'devel-stable' branch in
>> its entirety, and get everyone to resend all their pull requests.
>> That's *not* nice.
>
> What about simply ignoring Eric's latest pull request and have your
> 'devel-stable' be merged by Linus as is? ?Surely the earlier branch you
> merged from Eric wasn't that bad anyway, and Eric can certainly provide
> new commits on top later on to fix possible issues with that in order to
> bring his stuff to the same state as what he just asked you to pull.
>

Russell,

Regarding the problem of my rebased three commits that were already
merged into your tree, I'm seeing three ways out:

1. merge back your devel branch (tried and as you suggested is not a
very clean way)

2. merge linus v2.6.33-rc? and get the other commits rebased

3. rebase all the other commits against your devel branch or (devel-stable)

Just lemme know which is the best approach.

BTW, it would be very helpful to us if we are able to understand the
difference and how you maintain 'devel' and 'devel-stable' branch?

- eric
