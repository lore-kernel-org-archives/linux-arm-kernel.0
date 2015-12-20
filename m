From: robh@kernel.org (Rob Herring)
Date: Sat, 19 Dec 2015 21:39:43 -0600
Subject: [PATCH v10 3/8] ARM: dt: Binding documentation for imx25
 touchscreen controller
In-Reply-To: <1450101234-2191-4-git-send-email-mpa@pengutronix.de>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
 <1450101234-2191-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20151220033943.GO9883@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 02:53:49PM +0100, Markus Pargmann wrote:
> This is the touchscreen conversion queue binding documentation. It uses
> the shared imx25 ADC.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> 
> Notes:
>     Changes in v9:
>      - Updated binding descriptions
>     
>     Changes in v5:
>      - Fix signed/unsigned comparison
>      - Fix unused variable settling_time by putting it in the correct argument list
>      - Use continous conversion queue with the repeat feature and a proper
>        repeat-wait. Previously the touchscreen caused massive number of interrupts.
> 
>  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt

Acked-by: Rob Herring <robh@kernel.org>
