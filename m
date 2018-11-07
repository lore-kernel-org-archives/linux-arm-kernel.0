From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Nov 2018 08:10:21 -0800
Subject: [GIT PULL] ARM: dts: stratix10 fix for v4.20
In-Reply-To: <20181107160626.11892-1-dinguyen@kernel.org>
References: <20181107160626.11892-1-dinguyen@kernel.org>
Message-ID: <CAOesGMiZ=f5wAqXAFc6TfSc8g8Tm0Hk23B4E+nxgnFtJVbbY4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 8:06 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> Hi Arnd, Kevin, and Olof:
>
> Please pull in this ethernet dts entry for Stratix10.
>
> Thanks,
> Dinh
>
>
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
>
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_dts_fix_for_v4.20
>
> for you to fetch changes up to fd5ba6ee3187617287fb9cb187e3d6b3631210a3:
>
>   arm64: dts: stratix10: fix multicast filtering (2018-11-05 13:17:33 -0600)
>
> ----------------------------------------------------------------
> ARM: dts: stratix10: fix multicast filtering

For future pull requests, please keep in mind to write a sentence
about _why_ this pull request is needed. I.e. what's broken and how.

This mirrors how we handle patch descriptions (the code shows the what
and sometimes the how, but the description should cover the "why").

That being said, I've merged this now and added the message from the patch.


Thanks!

-Olof
