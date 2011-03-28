From: davidb@codeaurora.org (David Brown)
Date: Mon, 28 Mar 2011 12:14:31 -0700
Subject: [PATCHv2 1/3] msm: Remove arch-specific gpiomux tables
In-Reply-To: <1299522922-31294-1-git-send-email-rvaswani@codeaurora.org>
	(Rohit Vaswani's message of "Mon, 7 Mar 2011 10:35:22 -0800")
References: <1299522922-31294-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <8yatyenukfc.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07 2011, Rohit Vaswani wrote:

> Remove arch-specific gpiomux files and include the gpiomux configs
> as a part of the board file.
>
> Change-Id: I83de33c6d5f9e8e91832d8173d31a96cf11ce592
> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
> ---
> v2: Re-send
>
>  arch/arm/mach-msm/Makefile        |    4 +-
>  arch/arm/mach-msm/board-msm8x60.c |    3 ++
>  arch/arm/mach-msm/board-qsd8x50.c |   12 ++++++++
>  arch/arm/mach-msm/gpiomux-8x50.c  |   51 -------------------------------------
>  arch/arm/mach-msm/gpiomux-8x60.c  |   19 -------------
>  5 files changed, 17 insertions(+), 72 deletions(-)
>  delete mode 100644 arch/arm/mach-msm/gpiomux-8x50.c
>  delete mode 100644 arch/arm/mach-msm/gpiomux-8x60.c

Rohit, this change seems to have broken MMC/SD on the 8x50 target.  I'm
going to need to pull these out of my 'for-40' branch.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
