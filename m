From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Jun 2018 12:10:42 -0600
Subject: [PATCH v6 3/5] dt-bindings: timer: add i.MX EPIT timer binding
In-Reply-To: <20180607140544.22268-4-peron.clem@gmail.com>
References: <20180607140544.22268-1-peron.clem@gmail.com>
 <20180607140544.22268-4-peron.clem@gmail.com>
Message-ID: <20180611181042.GA30888@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 04:05:42PM +0200, Cl?ment P?ron wrote:
> From: Cl?ment Peron <clement.peron@devialet.com>
> 
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
> 
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt

Reviewed-by: Rob Herring <robh@kernel.org>
