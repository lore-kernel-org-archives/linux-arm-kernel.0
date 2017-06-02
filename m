From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Jun 2017 17:27:03 -0700
Subject: [GIT PULL] Gemini DTS updates, take one
In-Reply-To: <CACRpkdYVqQ4qyraofQO3sLUV=NjBn48a9sX-k+O9ASSaBY7pyA@mail.gmail.com>
References: <CACRpkdYVqQ4qyraofQO3sLUV=NjBn48a9sX-k+O9ASSaBY7pyA@mail.gmail.com>
Message-ID: <20170602002703.GM13314@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 11:03:14AM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is a first pull request of DTS updates to the Gemini architecture.
> 
> It tries to follow the merge strategy to merge DTS files with numeral
> and then patch in macros after -rc1.

Appreciated!

> The combines clock+reset DT bindings are part of the pull request,
> but the macros and drivers are merged by the subsystem maintainers
> for clock and reset respectively.
> 
> I will likely submit more Gemini DTS pulls based on this one as drivers
> trickle in: ATA/SATA, DMA and maybe Hans' USB work come to mind.
> But let's create a firm base for it all first.

Cool.

> Please pull it into ARM SoC!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/gemini-v4.13-dts-1
> 
> for you to fetch changes up to 664ed4e283926d753e876a1347b7729135a3f6b8:
> 
>   ARM: dts: Add clocks to the Gemini SoC (2017-05-24 10:50:22 +0200)

Merged into next/dt for v4.13. Thanks!

-Olof
