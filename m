From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Jul 2016 12:08:26 +0200
Subject: [PATCH 03/11] ASoC: ab8500-codec: remove platform data based probe
In-Reply-To: <CACRpkdZ7JW7iBzwL_7cY928Fp+CUNwPHQ6D8--CXvoLq7LMZAA@mail.gmail.com>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
 <1467722710-1577-3-git-send-email-linus.walleij@linaro.org>
 <20160705134445.GV6247@sirena.org.uk>
 <CACRpkdZ7JW7iBzwL_7cY928Fp+CUNwPHQ6D8--CXvoLq7LMZAA@mail.gmail.com>
Message-ID: <20160707100826.GN6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 05:22:22PM +0200, Linus Walleij wrote:

> Do you prefer to apply it to the ASoC tree? I can drop
> it from this series.

In general yes but it's also that if it looks like there should be some
dependency due to it being a series and I can't see one then that makes
me think I've missed something when reviewing and need to check.  Anyway:

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160707/bc6687c3/attachment.sig>
