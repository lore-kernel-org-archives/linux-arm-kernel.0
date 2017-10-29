From: horms@verge.net.au (Simon Horman)
Date: Sun, 29 Oct 2017 16:12:04 +0100
Subject: [PATCH v2 0/9] r8a7745/iwg22d DT rework + serial + HS-USB + IIC
In-Reply-To: <1508778570-28795-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1508778570-28795-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20171029151204.n2dem6j7t6o6ayhf@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 06:09:21PM +0100, Fabrizio Castro wrote:
> This series brings under the same roof a few patches that needed a v2
> and that are related to either r8a7745 or iwg22d, with the goal of making
> the merge process as smooth as possible.
> 
> Patches [1-4] define a new DT architecture for the iW-RainboW-G22D SODIMM
> Development Platform to include the configuration with the HDMI daughter
> board and to define the serial interfaces.
> 
> Patches [5-8] add USB function support to the r8a7745 SoC and to the
> iwg22d board. The patches providing the definition of compatible strings:
> * "renesas,r8a7745-usb-dmac", and
> * "renesas,usbhs-r8a7745"
> (on which these USB patches depend on) have been accepted by the
> respective maintainers already, but it will take a little bit for the
> definitions to appear on a renesas-devel tag. For reference:
> https://patchwork.kernel.org/patch/9990063/
> https://patchwork.kernel.org/patch/9987411/
> https://patchwork.kernel.org/patch/9990113/
> 
> Patch 9 adds IIC cores to the r8a7745 SoC.
> 
> The patches of this series apply smoothly on top of tag:
> "renesas-devel-20171018-v4.14-rc5".

Thanks, applied.
