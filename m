From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 Nov 2013 10:46:58 +0000
Subject: [PATCH 06/13] ASoC: ux500_pcm: Extend ux500 MSP binding for
 enumeration
In-Reply-To: <1383732985-18928-7-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20131106104658.GE11602@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:16:18AM +0000, Lee Jones wrote:

> +++ b/Documentation/devicetree/bindings/sound/ux500-msp.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>   - compatible       :"stericsson,ux500-msp-i2s"
>   - reg              : Physical base address and length of the device's registers.
> + - id               : MSP ID - used during component registration

I have no idea what this means or how one would pick the number?  It
looks like something purely internal to the driver...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/6df52946/attachment-0001.sig>
