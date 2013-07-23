From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Jul 2013 20:03:46 -0700
Subject: [GIT PULL] Nomadik defconfig updates
In-Reply-To: <CACRpkdZxSkLrKY1rZwdbo2ZJpVqExu7GRyhWN5T8V+aR_jx2Dw@mail.gmail.com>
References: <CACRpkdZxSkLrKY1rZwdbo2ZJpVqExu7GRyhWN5T8V+aR_jx2Dw@mail.gmail.com>
Message-ID: <20130723030346.GC16733@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 01:34:18PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> now we are past -rc1 and I'd like to have these defconfig changes for
> the Nomadik pulled in. It is similar in scope to the ux500 defconfig
> updates I sent the other week, and all have been circulated on the
> mailing list.
> 
> Please pull them in!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/nomadik-defconfig-for-arm-soc
> 
> for you to fetch changes up to fec57e15527ab2e3d22cfbf04f2b98f823f294ff:
> 
>   ARM: nomadik: configure for NO_HZ and HRTIMERS (2013-07-20 11:59:45 +0200)
> 
> ----------------------------------------------------------------
> This updates the Nomadik defconfig post-v3.11-rc1:
> - Update the baseline so we need not rely on make
>   oldconfig so much
> - MMC defconfig updates
> - Activate NO_HZ_IDLE and HRTIMERS

Pulled, thanks. Next time feel free to post these kind of patches as soon as
the bulk of our merge has been done so we can get it in during -rc1 or -rc2.


-Olof
