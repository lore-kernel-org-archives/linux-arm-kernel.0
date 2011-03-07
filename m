From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Mar 2011 00:31:08 -0800
Subject: [PATCH 0/3] ARM: Tegra: Enable audio (boards-for-next)
In-Reply-To: <1299303869-7827-1-git-send-email-swarren@nvidia.com>
References: <1299303869-7827-1-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTimPGLamT-UL5u5WtLTk9R_1sj5yMf3D6LK3yqwV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Stephen, I have applied these (pull request for Colin going
out shortly).

See my 3-patch series for my plan on how to handle the two additional
patches in the other series, i.e. stage them now for a merge during
the later part of the merge window.


-Olof

On Fri, Mar 4, 2011 at 9:44 PM, Stephen Warren <swarren@nvidia.com> wrote:
> This is the subset of patches to enable audio on Tegra Harmony that can be
> immediately applied to Olof's boards-for-next branch.
>
> Stephen Warren (3):
> ?ARM: Tegra: Add devices.c entries for audio
> ?ARM: Tegra: Create defines for SD-related GPIO names
> ?ARM: tegra: Harmony: Beginnings of audio support
>
> ?arch/arm/mach-tegra/board-harmony-pinmux.c ?| ? 28 ++++++-----
> ?arch/arm/mach-tegra/board-harmony.c ? ? ? ? | ? 38 ++++++++++++--
> ?arch/arm/mach-tegra/board-harmony.h ? ? ? ? | ? 14 +++++
> ?arch/arm/mach-tegra/board-seaboard-pinmux.c | ? 10 ++--
> ?arch/arm/mach-tegra/board-seaboard.c ? ? ? ?| ? ?6 +-
> ?arch/arm/mach-tegra/board-seaboard.h ? ? ? ?| ? ?3 +
> ?arch/arm/mach-tegra/devices.c ? ? ? ? ? ? ? | ? 70 +++++++++++++++++++++++++++
> ?arch/arm/mach-tegra/devices.h ? ? ? ? ? ? ? | ? ?4 ++
> ?arch/arm/mach-tegra/include/mach/iomap.h ? ?| ? ?3 +
> ?9 files changed, 150 insertions(+), 26 deletions(-)
>
>
