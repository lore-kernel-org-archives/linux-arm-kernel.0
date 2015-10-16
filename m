From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 16 Oct 2015 12:41:57 -0300
Subject: [PATCH 2/2] DT: nvmem: Add NXP LPC18xx EEPROM memory binding
 documentation
In-Reply-To: <1445004426-6271-3-git-send-email-ariel@vanguardiasur.com.ar>
References: <1445004426-6271-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1445004426-6271-3-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <CAAEAJfAAUWd9y8EBfV0irbRF_7EjxD1ycdPcNGScbs6oPxp4JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+DT bindings maintainers

As per the documentation in
Documentation/devicetree/bindings/submitting-patches.txt
this binding should be patch 1/2.

On 16 October 2015 at 11:07, Ariel D'Alessandro
<ariel@vanguardiasur.com.ar> wrote:
> Add the devicetree binding document for NXP LPC18xx EEPROM memory.
>
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> ---
>  .../devicetree/bindings/nvmem/lpc18xx_eeprom.txt   | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/lpc18xx_eeprom.txt
>
> diff --git a/Documentation/devicetree/bindings/nvmem/lpc18xx_eeprom.txt b/Documentation/devicetree/bindings/nvmem/lpc18xx_eeprom.txt
> new file mode 100644
> index 0000000..372ff8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/lpc18xx_eeprom.txt
> @@ -0,0 +1,26 @@
> +* NXP LPC18xx EEPROM memory NVMEM driver
> +
> +Required properties:
> +  - compatible: Should be "nxp,lpc1850-eeprom"

Correct me if I'm wrong, but I believe not all LPC18xx/43xx devices
have an EEPROM.

Isn't it restricted to LPC18x7/LPC43x7 devices?
Should the compatible be nxp,lpc1857-eeprom to avoid confusion?

-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
