From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 28 Jun 2018 19:55:51 -0700
Subject: [v4, 2/6] Documentation: DT: Add optional 'timeout-sec' property
 for sp805
In-Reply-To: <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <20180629025551.GA28627@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 11:01:33AM -0700, Ray Jui wrote:
> Update the SP805 binding document to add optional 'timeout-sec'
> devicetree property
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> index 0fa3629..bee6f1f 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> @@ -19,6 +19,8 @@ Required properties:
>  
>  Optional properties:
>  - interrupts:  Should specify WDT interrupt number
> +- timeout-sec: Should specify default WDT timeout in seconds. If unset, the
> +               default timeout is determined by the driver
>  
>  Example:
>  	watchdog at 66090000 {
