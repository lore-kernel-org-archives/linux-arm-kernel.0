From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 May 2015 18:29:04 +0200
Subject: [GIT PULL] Ux500 fixes
In-Reply-To: <CACRpkdZMCaCgJ89xPPy9pMRYDinuWwvBrXm+uKF12Ls4cNxvNQ@mail.gmail.com>
References: <CACRpkdZMCaCgJ89xPPy9pMRYDinuWwvBrXm+uKF12Ls4cNxvNQ@mail.gmail.com>
Message-ID: <201505071829.05147.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 April 2015, Linus Walleij wrote:
> Hi ARM SoC guys,
> 
> this are three patches fixing an issue in the Ux500 with SD/MMC
> GPIO regulators. All DTS fixes. Please pull it in for fixes.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> 
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/stericsson-fixes-v4.1
> 
> for you to fetch changes up to 11133db7a836b0cb411faa048f07a38e994d1382:
> 
>   ARM: ux500: Enable GPIO regulator for SD-card for snowball
> (2015-04-27 09:01:02 +0200)
> 
> ----------------------------------------------------------------
> This fixes an MMC/SD configuration issue present for some time
> in the Ux500 DT but triggered by proper error handling in v4.1-rc1.
> 

Pulled into the fixes branch, thanks!

	Arnd
