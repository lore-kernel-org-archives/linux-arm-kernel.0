From: ayaka@soulik.info (Ayaka)
Date: Thu, 1 Sep 2016 03:49:24 +0800
Subject: [RESEND PATCH 1/3] ARM: dts: Add TOPEET itop core board SCP
 package version
In-Reply-To: <20160831184226.GA23416@kozik-lap>
References: <a35686c3-294b-a16a-2b0e-0ef2fd460244@kernel.org>
 <1472648307-3818-1-git-send-email-ayaka@soulik.info>
 <20160831184226.GA23416@kozik-lap>
Message-ID: <647A092E-0CD6-4BA7-B3D8-AFF4BBEB611A@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



??? iPad ??

> Krzysztof Kozlowski <krzk@kernel.org> ? 2016?9?1? ??2:42 ???
> 
>> On Wed, Aug 31, 2016 at 08:58:27PM +0800, Randy Li wrote:
>> The TOPEET itop is a samsung exnynos 4412 core board, which have
>> two package versions. This patch add the support for SCP version.
>> 
>> Currently supported are USB3503A HSIC, USB OTG, eMMC, rtc and
>> PMIC. The future features are in the based board. Also MFC and
>> watchdog have been enabled.
>> 
>> Signed-off-by: Randy Li <ayaka@soulik.info>
>> ---
>> arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 490 ++++++++++++++++++++++++
>> 1 file changed, 490 insertions(+)
>> create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> 
> You are not making the review process easier... I asked for:
> 1. Not chaining the consecutive versions of patchset to the previous
> ones. But now you removed chain replies totally (also from patches).
> 2. Versioning all patches.... but this is a resend of v1?
> 
> The changelog and cover letters disappeared...
> 
> Please, make it simple:
> [PATCH v5 0/3] ARM: dts: exynos: some cover letter etc etc
>  \---[PATCH v5 1/3] ARM: dts: exynos: Add TOPEET itop core board SCP
>  \---[PATCH v5 2/3] ARM: dts: exynos: something more
>  \---[PATCH v5 3/3] ARM: dts: exynos: something even more
> 
> git format-patch and git send-email do this by default. In every
> sensible mail program this looks like that and is easy to read.
I see, sir. I misunderstand your order before(English is not my native). And thank you for you patient guide. I would resend in the morning.
> 
> I don't have a clue what happened to these patches and what is current
> status...
> 
> Best regards,
> Krzysztof
