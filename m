From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Apr 2012 15:21:13 -0600
Subject: Tegra for-next branch status check
Message-ID: <4F95C7C9.30205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Could I please ask you to take a quick look at Tegra's git repo:

git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git

... and double-check the construction of all the for-3.5 branches. I've
tended to mostly put stuff in topic branches rather than separating
things into the perhaps more typical soc/drivers/dt branches. Is this
scheme going to work out OK?

Note a couple dependencies in there:

for-3.5/gpio-pinmux-dependency is a copy of pinctrl's "base" tag.

for-3.5/gpio-pinmux depends on for-3.5/gpio-pinmux-dependency

for-3.5/tegra30-audio and for-3.5/usb-ulpi both depend on
for-3.5/gpio-pinmux.

Thanks for any feedback.
