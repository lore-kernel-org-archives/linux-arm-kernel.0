From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Jun 2014 10:58:39 +0100
Subject: [PATCH 3/5] dt: wm8904: add device tree binding document
In-Reply-To: <1401963572-10953-4-git-send-email-voice.shen@atmel.com>
References: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
 <1401963572-10953-4-git-send-email-voice.shen@atmel.com>
Message-ID: <20140606095839.GC2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 06:19:30PM +0800, Bo Shen wrote:

> +  - reg: the I2C address of the device.
> +  - clocks and clock-names: reference to
> +    <Documentation/devicetree/bindings/clock/clock-bindings.txt>

This all looks good except for in the above you should list the name of
the clock (mclk) - that name is part of the binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/d50c041b/attachment.sig>
