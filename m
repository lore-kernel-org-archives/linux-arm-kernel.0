From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 4 Apr 2018 20:35:58 +0200
Subject: [PATCH v7 2/4] i2c: add support for Socionext SynQuacer I2C
 controller
In-Reply-To: <20180403191151.14924-3-ard.biesheuvel@linaro.org>
References: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
 <20180403191151.14924-3-ard.biesheuvel@linaro.org>
Message-ID: <20180404183558.2arfnwbocsigkwii@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 09:11:49PM +0200, Ard Biesheuvel wrote:
> This is a cleaned up version of the I2C controller driver for
> the Fujitsu F_I2C IP, which was never supported upstream, and
> has now been incorporated into the Socionext SynQuacer SoC.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Removed two empty lines found by 'checkpatch --strict' and applied to
for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/3d1b1aae/attachment.sig>
