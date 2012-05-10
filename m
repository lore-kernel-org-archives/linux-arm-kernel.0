From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 10 May 2012 17:04:24 +0530
Subject: [GIT PULL] SPEAr SMI updates for v-3.5
In-Reply-To: <1336562073-24446-1-git-send-email-viresh.kumar@st.com>
References: <1336562073-24446-1-git-send-email-viresh.kumar@st.com>
Message-ID: <CAOh2x=kQVQ8W8+vkXGtmBpaqe-5s2o_oSrQ9EYj0UwBWCMP3Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 4:44 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> Hi Arnd,Olof,
>
> The following changes since commit 0e74bbef7c071aafb90ab10728197b1f325d1b5c:
>
> ?SPEAr: Update MAINTAINERS and Documentation (2012-05-09 14:46:46 +0530)
>
> are available in the git repository at:
>
> ?git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-smi-update

Please pull this instead:


The following changes since commit 78b3015d0ce85e94f75f58f5f04fb1674739bcc8:

  SPEAr: Update MAINTAINERS and Documentation (2012-05-10 16:15:07 +0530)

are available in the git repository at:

  git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-smi-update

for you to fetch changes up to 9f05a80564c35c397c5ce0f0b1106a420c3f5bdc:

  SPEAr: Update defconfigs (2012-05-10 16:15:08 +0530)

----------------------------------------------------------------
Viresh Kumar (2):
      SPEAr: Add SMI NOR partition info in dts files
      SPEAr: Update defconfigs

 arch/arm/boot/dts/spear1310-evb.dts  |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/spear1340-evb.dts  |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/spear300-evb.dts   |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/spear310-evb.dts   |   20 ++++++++++++++++++--
 arch/arm/boot/dts/spear320-evb.dts   |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/spear600-evb.dts   |   29 +++++++++++++++++++++++++++++
 arch/arm/configs/spear13xx_defconfig |    4 ++++
 arch/arm/configs/spear3xx_defconfig  |    4 ++++
 arch/arm/configs/spear6xx_defconfig  |    5 ++++-
 9 files changed, 159 insertions(+), 3 deletions(-)
