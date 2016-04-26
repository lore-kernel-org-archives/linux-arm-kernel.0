From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 10:52:41 -0700
Subject: [PATCH v2 2/2] ARM: dts: dra7x: Support QSPI MODE-0 operation at
 64MHz
In-Reply-To: <20160422193353.GA15316@rob-hp-laptop>
References: <1461151980-28139-1-git-send-email-vigneshr@ti.com>
 <1461151980-28139-3-git-send-email-vigneshr@ti.com>
 <20160422193353.GA15316@rob-hp-laptop>
Message-ID: <20160426175241.GL5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [160422 12:35]:
> On Wed, Apr 20, 2016 at 05:03:00PM +0530, Vignesh R wrote:
> > According to Data Manual(SPRS915P) of AM57x, TI QSPI controller on
> > DRA74(rev 1.1+)/DRA72 EVM can support up to 64MHz in MODE-0, whereas
> > MODE-3 is limited to 48MHz. Hence, switch to MODE-0 for better
> > throughput.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---
> > 
> > v2: rebased on linux-next 20160419 to include moving to
> > dra72-evm-common.dtsi
> > 
> > 
> >  Documentation/devicetree/bindings/spi/ti_qspi.txt | 7 +++++++
> >  arch/arm/boot/dts/dra7-evm.dts                    | 6 ++----
> >  arch/arm/boot/dts/dra72-evm-common.dtsi           | 6 ++----
> >  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applying both into omap-for-v4.7/dt thanks.

Tony
