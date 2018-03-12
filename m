From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 14:58:38 +0100
Subject: [GIT PULL] arm64: dts: hisilicon dts updates for v4.17
In-Reply-To: <5AA2AAC5.2000806@hisilicon.com>
References: <5AA2AAC5.2000806@hisilicon.com>
Message-ID: <CAK8P3a18WiQFRkBhtB82kstTGx=WKjYzD+eDCv=BmvsCqP1gQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 4:39 PM, Wei Xu <xuwei5@hisilicon.com> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the Git repository at:
>
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.17
>
> for you to fetch changes up to 928c4a5ce8684d2c8a37543b3361cfc12d83b167:
>
>   arm64: dts: Hi3660: Remove 'CPU_NAP' idle state (2018-03-02 16:19:44 +0000)
>
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon SoC DT updates for 4.17
>
> - Add XGE CPLD control support for hip07 SoC
> - Disable the SMMU on hip06 and hip07 SoCs becuase of
>   the hardware limitation
> - Enable HS200 mode for the MMC controller on hi6220 hikey board
> - Remove "cooling-{min|max}-level" this kind unused properties
>   for hi6220 SoC
> - Add watchdog node for hi6220 SoC
> - Remove "CPU_NAP" idle state on hikey960 board since it is
>   not stable and useless with the updated firmware

Pulled into next/dt, thanks!

       Arnd
