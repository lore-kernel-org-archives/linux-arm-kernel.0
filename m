From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 15:10:19 -0500
Subject: [PATCH v3] arm64: dts: rockchip: Add basic support for orion-r68
In-Reply-To: <1468577391-5096-1-git-send-email-matthias.bgg@gmail.com>
References: <1468577391-5096-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20160717201019.GA30063@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 12:09:51PM +0200, Matthias Brugger wrote:
> This patch adds basic support for the Tronsmart orion r86 set-top-box.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
> Changes since v2:
> - gpio-keys cleanpup
> - set sdmmc properties correctly
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    | 385 +++++++++++++++++++++
>  3 files changed, 390 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts

Acked-by: Rob Herring <robh@kernel.org>
