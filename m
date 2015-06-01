From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 18:05:52 +0200
Subject: [GIT PULL] DT changes for Ux500 and ARM generic
In-Reply-To: <CACRpkdZHxEDqwnp74qk3PdquivmrPaLZ3rSBfXdpuV73RYd24A@mail.gmail.com>
References: <CACRpkdZHxEDqwnp74qk3PdquivmrPaLZ3rSBfXdpuV73RYd24A@mail.gmail.com>
Message-ID: <2125765.VZgTlYS6Lb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 June 2015 14:29:53 Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> no comments on these DT bindings and additions,
> so could you please pull this to the next/dt branch in ARM SoC?
> 

Merged into next/dt.

> The following changes since commit 7dfc635894d1de84145fb02b210e6dfa5f50b6cc:
> 
>   ARM: dts: Add DT for Hitex LPC4350 Evaluation Board (2015-05-15
> 22:28:29 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/dt-for-armsoc
> 

I'd appreciate if you could do the branches based on either your own
earlier pull request or based on a clean -rc, to give a somewhat cleaner
git history.

I thought about rebasing the patches this time, but it's probably not
worth it here, as the result would be fairly similar.

	Arnd
