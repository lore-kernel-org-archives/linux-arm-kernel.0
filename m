From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Dec 2011 14:07:29 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111206124109.GT14542@n2100.arm.linux.org.uk>
References: <20111202182054.GA3250@arm.com>
 <20111206124109.GT14542@n2100.arm.linux.org.uk>
Message-ID: <20111206140729.GA31720@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 12:41:09PM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 02, 2011 at 06:20:54PM +0000, Catalin Marinas wrote:
> > If there are no further comments, could you please pull the ARM LPAE
> > branch below? They should be merged after Will's idmap patches (no real
> > conflict, just correctly functioning setup_mm_for_reboot).
> 
> Err, your tree contains a serious error.

I would say minor error but I agree, it needs fixing. This patch wasn't
originally part of my LPAE series as I hoped you would have merged it
during the last cycle. Now it had to be part of the pull request as LPAE
patches depend on it.

Anyway, I'll fix this and send you another pull request. Unless you
already merged your nopud patch in the devel-stable branch and I can
rebase LPAE on top, just let me know which one you'd prefer (and a
commit id if the latter).

Thanks.

-- 
Catalin

P.S. I say it's minor because it has the committer information. If you
     would pull someone else's branch which results in a fast-forward,
     you can't really tell whether it was a merge or cherry-pick, so the
     rule is not entirely consistent (unless you also mandate --no-ff
     for merges).
