From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 18:16:19 -0600
Subject: [PATCH v2 07/17] dt-bindings: serial: Document Actions Semi Owl
 UARTs
In-Reply-To: <20170224034055.18807-8-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-8-afaerber@suse.de>
Message-ID: <20170228001619.aksrqgoqelxvui6v@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 04:40:45AM +0100, Andreas F?rber wrote:
> This UART is found on S500 and S900 SoCs.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Adopted "actions" vendor prefix
>  
>  .../devicetree/bindings/serial/actions,owl-uart.txt      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt

Acked-by: Rob Herring <robh@kernel.org>
