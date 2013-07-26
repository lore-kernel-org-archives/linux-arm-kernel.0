From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 27 Jul 2013 01:31:05 +0200
Subject: [PATCH] pinctrl: tegra: expose config options for individual SoCs
In-Reply-To: <51E81F36.3030802@wwwdotorg.org>
References: <1374014077-22536-1-git-send-email-swarren@wwwdotorg.org>
 <51E81F36.3030802@wwwdotorg.org>
Message-ID: <CACRpkdaUeLG_y1SyinPKsdb9XDNJFup_sf9+EMOMjyW+7u_ZZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 7:00 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/16/2013 04:34 PM, Stephen Warren wrote:
>> I'm planning to remove CONFIG_ARCH_TEGRA_*_SOC, leaving just ARCH_TEGRA.
>> This will reduce the number of configurations that need to be supported
>> by core Tegra code, e.g. CPU idle, hotplug. As a precursor, we need to
>> update Kconfig for all Tegra drivers not to reference ARCH_TEGRA_*_SOC.
>>
>> The Tegra pinctrl driver contains a fairly large amount of SoC-specific
>> code and data. Introduce explicit config options so that the user can
>> trim the set of supported SoCs if they wish. Default these to on, since
>> most people will probably want to enable support for all SoCs. This also
>> avoids the need to change any defconfig files.
>
> I'd like to defer actually applying this patch. There is some discussion
> (in the thread for the equivalent ASoC patches) re: the best way to
> handle the ARCH_TEGRA_*_SOC Kconfig options which might affect this
> patch. Any review comment is still appreciated.

Just poke me when the discussion settles.

I'm totally unenlightened on this issue myself so not of much
help...

Yours,
Linus Walleij
