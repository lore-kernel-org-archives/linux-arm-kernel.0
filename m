From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 21 Oct 2016 21:38:41 +0800
Subject: [PATCH 00/10] [v3] arm64: dts: add QorIQ LS1046A SoC and boards
 support
In-Reply-To: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
References: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
Message-ID: <20161021133707.GH30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 04:09:53PM +0800, shh.xie at gmail.com wrote:
> From: Shaohui Xie <Shaohui.Xie@nxp.com>
> 
> This patchest adds support for QorIQ LS1046A SoC which is based on ARMv8
> architecture, also adds LS1046A-RDB and LS1046A-QDS board support.
> 
> Also, updates bindings for SoC-specific devices SCFG and DCFG,
> I2C devices, qoriq-clock and ahci-fsl-qoriq.
> 
> Mingkai Hu (2):
>   arm64: dts: add QorIQ LS1046A SoC support
>   arm64: dts: add LS1046A-RDB board support
> 
> Shaohui Xie (8):
>   dt-bindings: fsl: update for more SoCs
>   dt-bindings: fsl: updates bindings for some SoC-specific devices
>   dt-bindings: i2c: adds two more nxp devices
>   dt-bindings: qoriq-clock: update for more SoCs
>   dt-bindings: ahci-fsl-qoriq: updated for SoC ls1046a
>   Documentation: DT: Add entry for QorIQ LS1046A-RDB board
>   Documentation: DT: Add entry for QorIQ LS1046A-QDS board
>   arm64: dts: add LS1046A-QDS board support

I updated dt-bindings patch subject per Rob's comment, and then applied
the series.

Shawn
