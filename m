From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 May 2014 09:23:54 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v3.16
In-Reply-To: <cover.1401406177.git.horms+renesas@verge.net.au>
References: <cover.1401406177.git.horms+renesas@verge.net.au>
Message-ID: <CAOesGMh9vQ6F9gFzeYYCizSwpiOFwKONAvNM5U6wVi1ezdjhmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 4:31 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC fixes for v3.16.
>
> This corrects a bug that will be introduced in v3.15.
> The bug causes audio playback to fail on the Armadillo800 EVA board.
>
> I am posting this as a fix for v3.16 rather than v3.15 as I believe
> it is too late in the v3.15 cycle for a change of this nature.
> As such I would also like this change considered for v3.15 -stable.
>
>
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
>
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v3.16
>
> for you to fetch changes up to 730359857f5f0e1fac9881c63d389d73adb5f416:
>
>   ARM: shmobile: armadillo800eva: fixup HDMI sound flags setting (2014-05-28 12:57:07 +0900)

Merged, thanks.


-Olof
