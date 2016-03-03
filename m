From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 Mar 2016 15:53:48 +0100
Subject: [PATCH 03/17] dt-bindings: Add PLX Technology RPS IRQ Controller
 bindings
In-Reply-To: <1457005210-18485-4-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160303145348.GI15541@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 12:39:56PM +0100, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/interrupt-controller/plxtech,rps-irq.txt   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/plxtech,rps-irq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/plxtech,rps-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/plxtech,rps-irq.txt
> new file mode 100644
> index 0000000..db117a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/plxtech,rps-irq.txt

...

> +- compatible: Should be "plxtech,nas782x-rps"

Hi Neil

It would be nice to be consistent with the naming.

Maybe also the filename of the driver itself should be changed. You
had an interesting sorting problem in the Makefile, which a consistent
name would help with.

     Andrew
