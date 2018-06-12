From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Jun 2018 12:27:31 -0600
Subject: [PATCH v7 3/5] dt-bindings: timer: add i.MX EPIT timer binding
In-Reply-To: <20180611155001.3506-4-peron.clem@gmail.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
 <20180611155001.3506-4-peron.clem@gmail.com>
Message-ID: <20180612182731.GA11378@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2018 at 05:49:59PM +0200, Cl?ment P?ron wrote:
> From: Cl?ment Peron <clement.peron@devialet.com>
> 
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
> 
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt

Reviewed-by: Rob Herring <robh@kernel.org>
