From: dhdang@apm.com (Duc Dang)
Date: Fri, 30 Oct 2015 13:35:54 -0700
Subject: [GIT PULL] arm64: Second batch of DTS changes for X-Gene
 platforms queued for v4.4
In-Reply-To: <CADaLND=otWJX5vqzGdf0Y_pwiYHafWB5TwE9GXWnHG3M2r7fOw@mail.gmail.com>
References: <CADaLND=otWJX5vqzGdf0Y_pwiYHafWB5TwE9GXWnHG3M2r7fOw@mail.gmail.com>
Message-ID: <CADaLND=9YSB7UaqVKkhwuoVipVUN3mOQCB9cy_=DVf2m6nzOaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 12:08 PM, Duc Dang <dhdang@apm.com> wrote:
> Hi Arnd, Olof,
>
> The following changes since commit d2d0a722df735de52015f0c8a01f27a9ec28622e:
>
>   arm64: dts: Add poweroff device nodes for APM X-Gene 2 platform
> (2015-10-12 14:18:38 -0700)
>
> are available in the git repository at:
>
>   https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.4-2
>
> for you to fetch changes up to fa535e2632f275f0d5d4080d60c8e1331ac37549:
>
>   arm64: dts: Add L2 cache topology for APM X-Gene SoC (2015-10-26
> 02:31:43 -0700)
>
> ----------------------------------------------------------------
> Second batch of DTS changes for X-Gene platforms queued for v4.4
>
> This patch set adds DTS entries to support various IPs
> for X-Gene v1 and X-Gene v2 SoC:
> - X-Gene v1: Enable support for MMC, USB, GPIO controllers,
>   I2C controller, L2 Cache topology
> - X-Gene v2: Enable support for MMC, USB, GPIO controller,
>   I2C controller (with RTC), PCIe controller with GICv2m MSI,
>   EDAC, L2 Cache topology, TRNG
>
> ----------------------------------------------------------------
> Duc Dang (16):
>       arm64: dts: Add the arasan mmc DTS entries for APm X-Gene v2 SoC
>       arm64: dts: X-Gene: Do not reset or enable/disable clock for AHB block
>       arm64: dts: Add RNG device tree nodes for APM X-Gene v2 platform
>       arm64: dts: Add v2m MSI frame nodes for APM X-Gene v2 platforms
>       arm64: dts: Add PCIe node for APM X-Gene v2 platforms
>       arm64: dts: Add USB nodes for APM X-Gene v1 platforms
>       arm64: dts: Add USB nodes for APM X-Gene v2 platforms
>       arm64: dts: Add APM X-Gene v1 SoC GFC GPIO controller DTS entries
>       arm64: dts: Add APM X-Gene v2 SoC GFC GPIO controller DTS entry
>       arm64: dts: Add Designware GPIO dts binding for APM X-Gene v1 platform
>       arm64: dts: Add APM X-Gene v2 SoC Designware GPIO controller DTS entry
>       arm64: dts: Add APM X-Gene v2 SoC EDAC DTS entries
>       arm64: dts: Add Designware I2C controller DTS entries for X-Gene v1 SoC
>       arm64: dts: Add Designware I2C controller DTS entries for X-Gene
> v2 SoC platform
>       arm64: dts: Add RTC DTS entry for X-Gene v2 SoC platform
>       arm64: dts: Add L2 cache topology for APM X-Gene SoC
>
> Suman Tripathi (1):
>       arm64: dts: Add the arasan mmc DTS entries for APM X-Gene v1 SoC
>
>  arch/arm64/boot/dts/apm/apm-merlin.dts     |  12 +
>  arch/arm64/boot/dts/apm/apm-mustang.dts    |   4 +
>  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 401 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi     | 126 +++++++++
>  4 files changed, 543 insertions(+)

Hi Arnd, Olof,

I am sorry that I sent this pull request late. But do you still have
some cycle to have this change set pulled into your xgene/dt in
next/dt for 4.4?

Regards,
Duc Dang.
