From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Feb 2018 12:13:54 +0000
Subject: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623
 codec
In-Reply-To: <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
 <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
Message-ID: <20180221121354.GG8334@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 01:33:10PM +0900, Katsuhiro Suzuki wrote:

> +Optional properties:
> +- VCCA-supply : regulator phandle for the VCCA supply
> +- VCCP1-supply: regulator phandle for the VCCP1 supply
> +- VCCP2-supply: regulator phandle for the VCCP2 supply

These should be documented as mandatory unless the device genuinely
operates without power which seems unlikely.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180221/385276bc/attachment.sig>
