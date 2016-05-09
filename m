From: joel@jms.id.au (Joel Stanley)
Date: Mon, 9 May 2016 22:11:43 +0930
Subject: [PULL REQUEST] aspeed arch changes for 4.7
In-Reply-To: <1462796946-13579-1-git-send-email-joel@jms.id.au>
References: <1462796946-13579-1-git-send-email-joel@jms.id.au>
Message-ID: <CACPK8Xd6i0Fh79YBmF3FO--vfO+hEUxfTsTDyDxqUushhScRwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2016 at 9:59 PM, Joel Stanley <joel@jms.id.au> wrote:
> Hello,
>
> This is the initial pull request for the Aspeed BMC SoCs.

As you can see, this being my first time and all, I chose to use the
"PULL REQUEST" tag instead of the more traditional "GIT PULL".

I'll be sure to get it correct next time.

Cheers,

Joel

>
> I put 4.7 in the subject for this and the subsequent requests but if it's a bit
> late in the cycle then I understand.
>
> Following review I got rid of the board file by pushing the functionality out
> to a watchdog and clock driver, so it's just the Kconfig bits. I've also added
> myself to maintainers for the Aspeed arch and drivers as I intend on looking
> after them.
>
> Please pull if it looks okay.
>
>
> The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:
>
>   Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)
>
> are available in the git repository at:
>
>   https://github.com/shenki/linux.git tags/aspeed-for-4.7-arch
>
> for you to fetch changes up to 8c2ed9bcfbeb7f313b567b25e87effd75e7dc3d6:
>
>   arm: Add Aspeed machine (2016-05-09 17:41:14 +0930)
>
> ----------------------------------------------------------------
> aspeed arch tag for 4.7
>
> ----------------------------------------------------------------
> Joel Stanley (1):
>       arm: Add Aspeed machine
>
>  MAINTAINERS                  |  7 +++++++
>  arch/arm/Kconfig             |  2 ++
>  arch/arm/mach-aspeed/Kconfig | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
>  create mode 100644 arch/arm/mach-aspeed/Kconfig
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
