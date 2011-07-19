From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jul 2011 16:40:24 +0200
Subject: [GIT PULL] ARM: consolidate clkdev header files for v3.1
In-Reply-To: <20110718074414.GA23995@july>
References: <20110718074414.GA23995@july>
Message-ID: <201107191640.24421.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 July 2011, Kyungmin Park wrote:
> Hi Arnd,
> 
> Please pull clkdev header files consolidation.
> 
> Thank you,
> Kyungin Park
> 
> The following changes since commit 1765a367a3b5d5e9692949b0c5ec933eff2c0701:
> 
>   Merge branch 'gpio/merge' of git://git.secretlab.ca/git/linux-2.6 (2011-07-15 18:03:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/kmpark/linux-2.6-samsung clkdev

Thanks, I've rebased it onto v3.0-rc7 and pulled it into the
next/cross-platform branch. The reason for the rebase is that
I want to have a small set of branch points for the branches in
arm-soc, and this oen patch did not seem to have any dependencies
on patches after -rc7.

	Arnd
