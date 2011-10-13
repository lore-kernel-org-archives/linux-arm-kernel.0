From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 13 Oct 2011 09:03:31 -0700
Subject: [PATCH] ARM: tegra: update defconfig
In-Reply-To: <1318478219-9462-1-git-send-email-olof@lixom.net>
References: <1318478219-9462-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A063@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, October 12, 2011 9:57 PM:
> Refresh tegra_defconfig:
> 
> New options enabled: RTC, SPI, USB and USB_STORAGE together with
> corresponding tegra drivers. Also enable some of the common usb ethernet
> adapters.
> 
> Finally, enable new merged boards (Ventana) and the generic devicetree board.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

We should also enable ASoC (sound) support. Do you want to rev the patch, or
should I submit a patch on top of yours?

-- 
nvpublic
