From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Dec 2013 14:23:03 -0800
Subject: [GIT PULL] socfpga fix for 3.13
In-Reply-To: <1386106435-25013-1-git-send-email-dinguyen@altera.com>
References: <1386106435-25013-1-git-send-email-dinguyen@altera.com>
Message-ID: <CAOesGMhXSaTCWgUy+UTURkoyoFPTZBY+pC4Rr57uqBsMcfivDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 3, 2013 at 1:33 PM,  <dinguyen@altera.com> wrote:
> The following changes since commit b5afaa4672cc0f3d707ffa56c6b392646c323a8d:
>
>   Linux 3.13-rc1 (2013-12-03 15:00:46 -0600)
>
> are available in the git repository at:
>
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-kconfig-fixes-for-3.13
>
> for you to fetch changes up to 2f9f487fb54b4fa9c456921037fb508f5dd7e39b:
>
>   arm: dts: socfpga: Change some clocks of gate-clk type to perip-clk (2013-12-03 15:03:19 -0600)

Something odd is going on with this repo. Seems like you rebased a
bunch of commits from mainline such that they now have you as
committer (and different SHAs).

I'll cherry-pick the two of your patches into fixes instead. Please
see if you can figure out what you made wrong to cause this though for
the future. :)


-Olof
