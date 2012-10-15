From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 15 Oct 2012 22:49:32 +0530
Subject: [PATCH 1/9] uprobes: move function declarations out of arch
In-Reply-To: <1350242593-17761-1-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
Message-ID: <20121015171932.GA28723@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rabin Vincent <rabin@rab.in> [2012-10-14 21:23:05]:

> It seems odd to keep the function declarations in the arch header where
> they will need to be copy/pasted verbatim across arches.  Move them to
> the common header.
> 



> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/x86/include/asm/uprobes.h |    6 ------
>  include/linux/uprobes.h        |    8 ++++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 

You need to take care of the powerpc port
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=8b7b80b9ebb46dd88fbb94e918297295cf312b59

Also as Oleg pointed out, He has already posted changes on top of -tip.
So it probably makes sense to redo these patches on top of those
patches.

-- 
Thanks and Regards
Srikar
