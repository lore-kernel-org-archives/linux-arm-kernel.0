From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Apr 2013 23:20:28 +0200
Subject: [GIT PULL] Timer clean-ups for 3.10, Part 2
In-Reply-To: <516C0257.8040103@gmail.com>
References: <516720B4.3000703@gmail.com>
 <20130413065056.GB14735@quad.lixom.net> <516C0257.8040103@gmail.com>
Message-ID: <201304152320.28401.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 April 2013, Rob Herring wrote:
> It is quite messed up because the mct timer changes are not based on
> arm-soc/clksrc/cleanup. Any timer changes adding CLKSRC_OF support need
> to be based on this. I've fixed it up in this branch (untested):
> 
> git://sources.calxeda.com/kernel/linux.git exynos-mct-merge
> 
> I merged with clksrc-cleanup-for-3.10-part2 and fixed it in the merge,
> but really either the mct branch should be rebased or some of the
> changes can be a preparatory commit before merging.

Note that I also merged the branches when pulling in the samsung changes,
and did a complex merge there. We should ensure that we use the same
merge here.

	Arnd
