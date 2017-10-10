From: robh@kernel.org (Rob Herring)
Date: Tue, 10 Oct 2017 13:57:44 -0500
Subject: [PATCH v2 2/4] nvmem: meson-efuse: indicate that this driver is
 only for Meson GX SoCs
In-Reply-To: <20171002232804.20042-3-martin.blumenstingl@googlemail.com>
References: <20171002232804.20042-1-martin.blumenstingl@googlemail.com>
 <20171002232804.20042-3-martin.blumenstingl@googlemail.com>
Message-ID: <20171010185744.spvwvtjjx46ijdfv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 01:28:02AM +0200, Martin Blumenstingl wrote:
> The current Amlogic Meson eFuse driver only supports the 64-bit SoCs
> (GXBB and newer). Older SoCs cannot be supported by the same driver
> because they do not use the meson secure monitor firmware to access the
> hardware.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt | 2 +-
>  drivers/nvmem/Kconfig                                     | 4 ++--
>  drivers/nvmem/meson-efuse.c                               | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
