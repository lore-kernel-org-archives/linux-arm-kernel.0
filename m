From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 09:34:20 -0600
Subject: [PATCH v3 5/6] dt-bindings: Move Paralella board to Xilinx
In-Reply-To: <20180712041024.20583-6-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
 <20180712041024.20583-6-luaraneda@gmail.com>
Message-ID: <20180716153420.GA15187@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 12:10:23AM -0400, Luis Araneda wrote:
> Move the Adapteva Parallela board to Xilinx dt-bindings,
> as it's based on a Zynq SoC from Xilinx
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/adapteva.txt | 7 -------
>  Documentation/devicetree/bindings/arm/xilinx.txt   | 3 +++
>  2 files changed, 3 insertions(+), 7 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt

Reviewed-by: Rob Herring <robh@kernel.org>
