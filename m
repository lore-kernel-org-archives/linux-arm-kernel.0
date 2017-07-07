From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Jul 2017 13:44:20 +0100
Subject: [PATCH v2 7/9] ASoC: atmel-classd: remove aclk clock from DT
 binding
In-Reply-To: <20170704115927.32662-8-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
 <20170704115927.32662-8-quentin.schulz@free-electrons.com>
Message-ID: <20170707124419.jfkgyl66wi7jfhnu@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 01:59:25PM +0200, Quentin Schulz wrote:
> Since gclk (generated-clk) is now able to determine the rate of the
> audio_pll, there is no need for classd to have a direct phandle to the
> audio_pll while already having a phandle to gclk.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170707/c3aac6b6/attachment.sig>
