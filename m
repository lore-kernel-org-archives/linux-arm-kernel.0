From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 08 Jul 2010 01:58:56 -0400 (EDT)
Subject: [PATCH 3/4] ARM: atomic ops: add memory constraints to inline asm
In-Reply-To: <004101cb1df3$5825ecd0$0871c670$%deacon@arm.com>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
	<1277906688-12065-3-git-send-email-will.deacon@arm.com>
	<1277906688-12065-4-git-send-email-will.deacon@arm.com>
	<004101cb1df3$5825ecd0$0871c670$%deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1007080154050.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Jul 2010, Will Deacon wrote:

> Hello,
> 
> > Subject: [PATCH 3/4] ARM: atomic ops: add memory constraints to inline asm
> > 
> > This patch adds suitable memory constraints to the atomic operations on ARM
> 
> Does anybody have any feedback on this patch? The other three in the
> series are straightforward, but I'd like another set of eyes to go over this
> code [I know it makes for tough reading!] before submitted to the patch
> system.
> 
> Any comments appreciated!

In addition to the comments I've just provided, I think you should also 
add a

Cc: stable at kernel.org

to the list of tags for those patches.  They are definitely fixing real 
correctness issues.


Nicolas
