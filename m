From: johan@kernel.org (Johan Hovold)
Date: Mon, 22 Sep 2014 17:22:03 +0200
Subject: [PATCH v5 8/9] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <1411377058-26155-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1411377058-26155-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411377058-26155-9-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140922152203.GJ5237@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 11:10:57AM +0200, Boris BREZILLON wrote:
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> new file mode 100644
> index 0000000..5b2bb73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> @@ -0,0 +1,23 @@
> +Atmel AT91SAM9260 Real Time Timer
> +
> +Required properties:
> +- compatible: should be: "atmel,at91sam9260-rtt"
> +- reg: should encode the memory region of the RTT controller
> +- interrupts: rtc alarm/event interrupt

rtt alarm

> +- clocks: should contain one clock pointing the the slow clk
> +- atmel,rtt-rtc-time-reg: should encode the GPBR register used to store
> +	the RTC time. The first cell should point to the GPBR node and

"used to store the time base when the RTT is used as an RTC"?

Johan
