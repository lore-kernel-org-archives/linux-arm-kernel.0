From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Jun 2017 17:16:06 +0100
Subject: [PATCH 1/2] ASoC: add bindings for ZTE zx-aud96p22 audio codec
In-Reply-To: <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170619161606.g6nabi2w5mmmjbcw@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 17, 2017 at 10:09:33PM +0800, Shawn Guo wrote:

> +Optional properties:
> + - zte,pa-gpios: The GPIO to enable external power amplifier

If there's an external power amplifier this is a separate chip to this
CODEC and should therefore be separately controlled and integrated as
part of the machine integration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170619/b2ff6e53/attachment.sig>
