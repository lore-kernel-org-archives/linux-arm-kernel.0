From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 14:57:13 -0500
Subject: [PATCH v3 2/3] dt-bindings: net: dsa: Document B53 SRAB
 interrupts and registers
In-Reply-To: <20180831192039.11842-3-f.fainelli@gmail.com>
References: <20180831192039.11842-1-f.fainelli@gmail.com>
 <20180831192039.11842-3-f.fainelli@gmail.com>
Message-ID: <20180910195713.GA14119@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Aug 2018 12:20:38 -0700, Florian Fainelli wrote:
> Document the Broadcom roboswitch Switch Register Access Block interrupt
> lines and additional register base addresses for port mux configuration
> and SGMII status/configuration registers.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/net/dsa/b53.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
