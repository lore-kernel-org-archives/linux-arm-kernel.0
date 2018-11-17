From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 10:03:05 -0600
Subject: [PATCH v2 02/17] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
In-Reply-To: <20181116162403.49854-3-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-3-lkundrak@v3.sk>
Message-ID: <20181117160305.GA31494@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018 17:23:48 +0100, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - s/cmd-gpio/cmd-gpios/
> - s/ready-gpio/ready-gpios/ in the documentation paragraph
> - Remove status = "okay" from the example
> 
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
