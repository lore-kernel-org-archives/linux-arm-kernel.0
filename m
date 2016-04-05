From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Tue, 5 Apr 2016 23:37:33 +0200
Subject: [PATCH 4/5] devicetree: leds: Introduce "panic-blink" optional
 property
In-Reply-To: <1459801326-5541-5-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1459801326-5541-5-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <5704301D.7040300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 04/04/2016 10:22 PM, Ezequiel Garcia wrote:
> It's desirable to specify which LEDs are to be blinked on a kernel
> panic. Therefore, introduce a devicetree boolean property to mark
> which LEDs should be treated this way.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>   Documentation/devicetree/bindings/leds/common.txt | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 68419843e32f..dd409df9203a 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -37,6 +37,8 @@ Optional properties for child nodes:
>                        property is mandatory for the LEDs in the non-flash modes
>                        (e.g. torch or indicator).
>
> +- panic-blink : Mark this LED to be used by the panic LED trigger.

I'd say that 'panic-indicator' would be more informative.

Please next time cc also devicetree list and maintainers.

> +
>   Required properties for flash LED child nodes:
>   - flash-max-microamp : Maximum flash LED supply current in microamperes.
>   - flash-max-timeout-us : Maximum timeout in microseconds after which the flash
>

-- 
Best regards,
Jacek Anaszewski
