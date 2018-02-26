From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 26 Feb 2018 11:43:06 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: set CONFIG_DAVINCI_WATCHDOG=y
In-Reply-To: <1516037371-3932-1-git-send-email-david@lechnology.com>
References: <1516037371-3932-1-git-send-email-david@lechnology.com>
Message-ID: <7849e3ae-cebe-b067-213c-3fe0d6e7a18e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 January 2018 10:59 PM, David Lechner wrote:
> This changes CONFIG_DAVINCI_WATCHDOG from a module to a compiled-in
> option. Since the reset function has been moved out of the mach code in
> commit 0808d3260456 ("ARM: davinci: remove watchdog reset") and into the

commit id adjusted since the said patch did not make it to v4.16

> watchdog driver, devices cannot reboot unless the watchdog driver is
> loaded, so make it a compiled-in option so that we can always reboot, even
> when modules are not loaded.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Suggested-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.17/defconfig

Thanks,
Sekhar
