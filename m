From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Sep 2016 07:13:47 -0500
Subject: [PATCH V3 1/5] Documentation: Add support for TI System Control
 Interface (TI-SCI) protocol
In-Reply-To: <20160906190127.23522-2-nm@ti.com>
References: <20160906190127.23522-1-nm@ti.com>
 <20160906190127.23522-2-nm@ti.com>
Message-ID: <20160916121347.GA29618@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 02:01:23PM -0500, Nishanth Menon wrote:
> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
> is used in Texas Instrument's System on Chip (SoC) such as those in
> newer SoCs in the keystone processor family starting with K2G.
> 
> This message protocol is used to communicate between various compute
> or processing entities (such as ARM, DSP etc.) with a central system
> controller entity.
> 
> TI-SCI message protocol provides support for management of various
> hardware entities within the SoC.
> 
> The message protocol can be found here:
> http://processors.wiki.ti.com/index.php/TISCI
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V3:
> 	- All dependent nodes like PD/Clk are children of TISCI node
> 	- minor formatting updates
> 
> V2: https://patchwork.kernel.org/patch/9305413/
> V1: https://patchwork.kernel.org/patch/9291343/
> 
>  .../devicetree/bindings/arm/keystone/ti,sci.txt    | 81 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt

Acked-by: Rob Herring <robh@kernel.org>
