From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Nov 2012 08:12:46 -0800
Subject: [GIT PULL 2/6] DaVinci cleanup for v3.8
In-Reply-To: <1351620701-16516-2-git-send-email-nsekhar@ti.com>
References: <1351620701-16516-1-git-send-email-nsekhar@ti.com>
 <1351620701-16516-2-git-send-email-nsekhar@ti.com>
Message-ID: <20121106161246.GA3247@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 11:41:37PM +0530, Sekhar Nori wrote:
> The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:
> 
>   Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-for-v3.8/cleanup


Pulled, but would you mind moving your tree to a better git hosting service?

It takes _forever_ to do a pull from gitorious. Do you have a signed
PGP key so you can get a kernel.org account, per chance?


-Olof
> 
> for you to fetch changes up to baad1b33f4d86d223d665fcefa79b4acc832a269:
> 
>   ARM: davinci: board-dm646x-evm.c: Remove unecessary semicolon (2012-10-26 13:59:01 +0530)
> 
> ----------------------------------------------------------------
> These changes make minor clean-ups to remove some
> unused MUSB defines and an unnecessary semicolon.
> 
> ----------------------------------------------------------------
> Constantine Shulyupin (1):
>       ARM: davinci: usb: remove CONFIG_USB_MUSB_HOST etc
> 
> Peter Senna Tschudin (1):
>       ARM: davinci: board-dm646x-evm.c: Remove unecessary semicolon
> 
>  arch/arm/mach-davinci/board-dm646x-evm.c |    2 +-
>  arch/arm/mach-davinci/usb.c              |    6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
