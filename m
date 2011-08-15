From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Aug 2011 12:41:47 +0100
Subject: [PATCH] Fix non-LPAE boot regression.
In-Reply-To: <20110813143903.GQ4775@n2100.arm.linux.org.uk>
References: <201108131556.27301.anarsoul@gmail.com>
	<1313240299-24712-1-git-send-email-anarsoul@gmail.com>
	<CAHkRjk4p1kqwKGiW_XRFU0aap98QkvRGRs0hwsBR4CcfM5RKqA@mail.gmail.com>
	<20110813143903.GQ4775@n2100.arm.linux.org.uk>
Message-ID: <20110815114146.GA21596@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 13, 2011 at 03:39:03PM +0100, Russell King - ARM Linux wrote:
> I think this patch is trying to do too much in one go.  It needs splitting
> up into two, just like is done with the C PGDIR_SHIFT vs PMD_SHIFT stuff
> (and arguably the first part should be combined with the patch fixing the
> PGDIR_SHIFT stuff.)

OK, I'll do this and repost the two patches in reply to this one (and
merge one of them with the PMD_SHIFT but I would avoid reposting the
full series again).

For patch clarity, I'll fold Vasily's fix as well rather than keeping it
in a separate patch.

-- 
Catalin
