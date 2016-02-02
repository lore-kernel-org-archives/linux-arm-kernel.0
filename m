From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Feb 2016 09:32:05 +0100
Subject: [PATCH 1/4] ARM: dts: ls1021a: add PCIe dts node
In-Reply-To: <1454401807-28751-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1454401807-28751-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <1640613.2DY3gpScUX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 February 2016 16:30:07 Minghuan Lian wrote:
> LS1021a contains two PCIe controllers. The patch adds their node to
> dts file.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

Looks ok to me, please submit to the ARM imx maintainers for merging.

	Arnd
