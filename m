From: will.deacon@arm.com (Will Deacon)
Date: Sun, 03 Apr 2011 13:22:54 +0100
Subject: [PATCH] ARM: hw_breakpoint: clear DBGVCR out of reset
In-Reply-To: <4D9820D6.5040502@codeaurora.org>
References: <1301657056-30065-1-git-send-email-will.deacon@arm.com>
	<4D9820D6.5040502@codeaurora.org>
Message-ID: <1301833374.5022.9.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Sun, 2011-04-03 at 08:25 +0100, Stephen Boyd wrote:
> On 4/1/2011 4:24 AM, Will Deacon wrote:
> > The DBGVCR, used for configuring vector catch debug events, is UNKNOWN
> > out of reset on ARMv7. When enabling monitor mode, this must be zeroed
> > to avoid UNPREDICTABLE behaviour.
> >
> > This patch adds the zeroing code to the debug reset path.
> >
> > Reported-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Please Cc stable as this fix should go to the 37 and 38 stable trees.

Will do. If you could please confirm that it fixes the problems reported
initially then that would be great.

Thanks,

Will
