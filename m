From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Jul 2017 14:00:00 -0500
Subject: [PATCH v5 3/8] dt-bindings: bus: Add documentation for the
 Technologic Systems NBUS
In-Reply-To: <20170714203218.14409-4-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170714203218.14409-4-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20170717190000.n2lifnduqzgp4b6g@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 04:32:13PM -0400, Sebastien Bourdelin wrote:
> Add binding documentation for the Technologic Systems NBUS that is used
> to interface with peripherals in the FPGA of the TS-4600 SoM.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
> Changes v4 -> v5:
>   - fix missing signed off
> 
> Changes v3 -> v4:
>   - rebase on master
>   - fix vendor prefixes for dts properties (suggested by Rob Herring)
>   - v3 was acked by Linus Walleij
> 
> Changes v2 -> v3:
>   - rebase on master
>   - fix typo (suggested by Rob Herring)
> 
> Changes v1 -> v2:
>   - rebase on master
>   - remove the simple-bus compatibility as the root node will now
>   populate child nodes (suggested by Rob Herring)
>   - use the ts vendor prefix for gpios (suggested by Rob Herring)
> ---
>  Documentation/devicetree/bindings/bus/ts-nbus.txt | 50 +++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt

Acked-by: Rob Herring <robh@kernel.org>
