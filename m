From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 May 2014 10:41:31 -0600
Subject: [PATCH 2/2] ARM: tegra: add device tree for SHIELD
In-Reply-To: <1399883209-31169-3-git-send-email-acourbot@nvidia.com>
References: <1399883209-31169-1-git-send-email-acourbot@nvidia.com>
 <1399883209-31169-3-git-send-email-acourbot@nvidia.com>
Message-ID: <5370F9BB.9040608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2014 02:26 AM, Alexandre Courbot wrote:
> NVIDIA SHIELD is a portable Android console embedded a Tegra 4 SoC with
> 2GB RAM and a 720p panel.
> 
> The following hardware is enabled by this device tree: UART, eMMC, USB
> (needs external power), PMIC, backlight, joystick, SD card, GPIO keys.
> 
> DSI panel, HDMI output, charger, self-powered USB, audio, wifi bluetooth
> are not supported yet but might be by future patches (likely in that
> order).
> 
> Touch panel and sensors will probably never be supported.
> 
> Initrd addresses are hardcoded to match the static values used by the
> bootloader, since it won't add them for us. All the same, a kernel
> command-line is provided to replace the one passed by the
> bootloader which is filled with garbage.
> 
> NVIDIA SHIELD is typically booted with an appended DTB to avoid
> modifications made by the bootloader.

I've applied this one patch to Tegra's for-3.16/dt branch.
