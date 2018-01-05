From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 22:37:29 -0800
Subject: [GIT PULL] arm: actions: dt for v4.16 #1
In-Reply-To: <20171222102107.5661-1-afaerber@suse.de>
References: <20171222102107.5661-1-afaerber@suse.de>
Message-ID: <20180105063729.ttkwbct2smxx5x3z@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 11:21:05AM +0100, Andreas F?rber wrote:
> Hi Olof and Arnd,
> 
> Here's my dt pull for Actions Semi.
> This adds one new S500 based board, which I already updated to new SPDX style.
> A second pull will follow after I've converted the existing boards.
> 
> Regards,
> Andreas
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-dt-for-4.16
> 
> for you to fetch changes up to 271a70da383cf69f32742d9e2d01a7b16d04d60c:
> 
>   arm: dts: owl-s500: Add Sparky (2017-12-22 10:53:52 +0100)
> 
> ----------------------------------------------------------------
> Actions Semi arm based SoC DT for v4.16
> 
> This adds a DT for the Allo.com Sparky SBC.
> 
> ----------------------------------------------------------------
> Andreas F?rber (3):
>       dt-bindings: Add vendor prefix for Allo.com
>       dt-bindings: arm: actions: Add Sparky
>       arm: dts: owl-s500: Add Sparky

Merged.

Tiny nit: For 32-bit, we use ARM: as prefix (and arm64: for 64-bit).
Yes, it's confusing. :)


-Olof
