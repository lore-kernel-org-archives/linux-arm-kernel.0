From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 02 May 2014 12:20:44 -0600
Subject: [PATCH v2] ARM: tegra: add Tegra Note 7 device tree
In-Reply-To: <1399017548-1638-1-git-send-email-acourbot@nvidia.com>
References: <1399017548-1638-1-git-send-email-acourbot@nvidia.com>
Message-ID: <5363E1FC.3080006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2014 01:59 AM, Alexandre Courbot wrote:
> Tegra Note 7 is a consumer tablet embedding a Tegra 4 SoC with 1GB RAM
> and a 720p panel.
> 
> The following hardware is enabled by this device tree: UART, eMMC, USB
> (needs external power), PMIC, backlight, DSI panel, keys.
> 
> SD card, HDMI, charger, self-powered USB, audio, wifi, bluetooth are not
> yet supported but might be by future patches (likely in that order).
> 
> Touch panel, sensors & cameras will probably never be supported.
> 
> Pinctrl is not set yet, as the bootloader-provided values allow us to
> use the currently supported hardware.
> 
> Initrd addresses are hardcoded to match the static values used by the
> bootloader, since it won't add them for us. All the same, a kernel
> command-line is provided to replace the one passed by the bootloader
> which is filled with garbage.

I've applied this to Tegra's for-3.16/dt branch.
