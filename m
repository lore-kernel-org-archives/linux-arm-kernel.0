From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jul 2010 11:03:08 +0100
Subject: [PATCH 3/4] ARM: atomic ops: add memory constraints to inline asm
In-Reply-To: <alpine.LFD.2.00.1007080154050.6020@xanadu.home>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
	<1277906688-12065-3-git-send-email-will.deacon@arm.com>
	<1277906688-12065-4-git-send-email-will.deacon@arm.com>
	<004101cb1df3$5825ecd0$0871c670$%deacon@arm.com>
	<alpine.LFD.2.00.1007080154050.6020@xanadu.home>
Message-ID: <004d01cb1e84$c48136f0$4d83a4d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

> > > Subject: [PATCH 3/4] ARM: atomic ops: add memory constraints to inline asm
> > >
> > > This patch adds suitable memory constraints to the atomic operations on ARM

> In addition to the comments I've just provided, I think you should also
> add a
> 
> Cc: stable at kernel.org
> 
> to the list of tags for those patches.  They are definitely fixing real
> correctness issues.

I've submitted these patches as 621{1-3}/1. I Cc'd stable for the first
two patches because the first one is required in order to apply the second.

Cheers,

Will
