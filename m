From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:13:36 +0100
Subject: [GIT PULL] STM32 defconfig changes for v4.17 #1
In-Reply-To: <04188a3b-6432-3e2e-8e4a-fb5522a1c8aa@st.com>
References: <04188a3b-6432-3e2e-8e4a-fb5522a1c8aa@st.com>
Message-ID: <CAK8P3a2sv40VxefJbgMET99Dw1KuVKsvag0vyz08Go11+-oYxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 12:18 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Olof, Arnd and Kevin,
>
> Please consider this first round of STM32 defconfig updates for v4.17:
>
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-defconfig-for-v4.17-1
>
> for you to fetch changes up to 1c92d4a0edcfff0fee78ade27eb41ce3fc0d071a:
>
>   ARM: configs: stm32: Enable MMC_ARMMMCI and EXT3_FS support (2018-02-27
> 11:00:49 +0100)
>
> ----------------------------------------------------------------
> STM32 defconfig updates for v4.17, round 1
>
> Highlights:
> ----------
>  -Add STM32 support (for MPU) to multi-v7-defconfig
>  -Enable MMCI and EXT3_FS support
>

Pulled into next/soc as well, thanks

      Arnd
