From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Mar 2012 12:50:11 +0000
Subject: [GIT PULL] Samsung SoC EXYNOS5250 arch for v3.4
In-Reply-To: <4F61FA0D.1050007@samsung.com>
References: <4F61FA0D.1050007@samsung.com>
Message-ID: <201203161250.11353.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Kukjin Kim wrote:
> Hi Arnd, Olof,
> 
> Thank you for kindly review for EXYNOS5 and addressed comments.
> 
> Here are 'pull request' for supporting EXYNOS5250.
> 
> Please pull from:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> next/soc-exynos5250-arch
> 
> It is based on next/devel-samsung-dma which has been pulled into arm-soc 
> to avoid merge conflicts, because they touches same files.
> And it is including additional two commits, one commit for fix 
> exynos4-dt build error which is caused by this series and one for 
> supporting lcd clkdev.
> 
> If any problems, please kindly let me know.

As you may have noticed from Stephen's notification about the merge
conflict, I have put this into the next/soc2 branch now.

I'm not too happy with the resolution of my comments, but in the
end I think it's better to have it in the tree than not have it.
While you did reply with explanations for why some of the patches
were necessary, you did not actually put the explanations into 
the changeset descriptions but only sent a reply to my emails.

I don't think that the merge conflict is problematic, especially
since Linus won't see the same thing that Stephen did, but as I
wrote in the other mail, please check that my resolution was correct.

	Arnd
