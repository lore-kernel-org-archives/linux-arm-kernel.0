From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jun 2014 01:29:00 +0200
Subject: [PATCHv5 2/2] pwm: sunxi: document OF bindings
In-Reply-To: <1400523003-27082-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1400523003-27082-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1400523003-27082-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140617232859.GC25525@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 08:10:03PM +0200, Alexandre Belloni wrote:
> This is the documentation for the Allwinner Socs PWM bindings.

"SoCs".

> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt b/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
[...]
> +Allwinner PWM controller

"Allwinner SoC"?

> +
> +Required properties:
> +  - compatible: should be one of:
> +    - "allwinner,sun4i-a10-pwm"
> +    - "allwinner,sun7i-a20-pwm"
> +  - reg: physical base address and length of the controller's registers
> +  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> +    the cells format.
> +  - clocks: from common clock binding, handle to the parent clock.

This is a sentence, so should start with a capital letter.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/75cf8768/attachment.sig>
