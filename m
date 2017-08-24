From: horms@verge.net.au (Simon Horman)
Date: Thu, 24 Aug 2017 06:44:30 -0400
Subject: [PATCH 0/2] ARM: dtsi: r8a7745: iwg22m: Add eMMC support
In-Reply-To: <1502991103-2325-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1502991103-2325-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20170824104430.GA27788@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 06:31:41PM +0100, Fabrizio Castro wrote:
> This series adds eMMC support to r8a7745 SoC and iW-RainboW-G22M-SM SoM.
> 
> Testing has been made on top of Renesas's devel branch.
> 
> The patches contained in this series depend on the following patches:
> [1/2] ARM: dts: iwg22m: Add iWave RZG1E SODIMM SOM - https://patchwork.kernel.org/patch/9901619/
> [2/2] ARM: dts: iwg22d-sodimm: Add support for iWave G22D-SODIMM board - https://patchwork.kernel.org/patch/9901623/
> dt-bindings: mmc: sh_mmcif: Document r8a7745 DT bindings - https://patchwork.kernel.org/patch/9902199/

Thanks, applied for v4.15.
