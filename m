From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Dec 2017 09:26:18 +0100
Subject: [PATCH 3/3] arm64: dts: renesas: r8a7796: add reg properties to
 pciec[01] nodes
In-Reply-To: <CAMuHMdW6hPCT0J0PHvXkJos51=0QjWijebWZZ5C_cgKzNS5=6Q@mail.gmail.com>
References: <20171212082436.12210-1-horms+renesas@verge.net.au>
 <20171212082436.12210-4-horms+renesas@verge.net.au>
 <CAMuHMdW6hPCT0J0PHvXkJos51=0QjWijebWZZ5C_cgKzNS5=6Q@mail.gmail.com>
Message-ID: <20171213082617.wj343fwkfv6aporx@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 10:50:33AM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 12, 2017 at 9:24 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add reg properties to pciec[01] placeholder nodes
> >
> > This is to stop the compiler complaining as follows:
> > $ make
> > ...
> >   DTC     arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb
> > arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at fe000000 has a unit name, but no reg property
> > arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at ee800000 has a unit name, but no reg property
> > arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pcie at fe000000 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pcie at ee800000 missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb
> > arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at fe000000 has a unit name, but no reg property
> > arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at ee800000 has a unit name, but no reg property
> > arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pcie at fe000000 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pcie at ee800000 missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb
> > arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at fe000000 has a unit name, but no reg property
> > arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at ee800000 has a unit name, but no reg property
> > arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pcie at fe000000 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pcie at ee800000 missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb
> > arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at fe000000 has a unit name, but no reg property
> > arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (unit_address_vs_reg): Node /soc/pcie at ee800000 has a unit name, but no reg property
> > arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pcie at fe000000 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pcie at ee800000 missing or empty reg/ranges property
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
