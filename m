From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 4 Apr 2018 20:35:01 +0200
Subject: [PATCH v6 2/3] i2c: add support for Socionext SynQuacer I2C
 controller
In-Reply-To: <20180404183411.rrukznuwmtbwwyjd@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180325110747.8852-3-ard.biesheuvel@linaro.org>
 <20180404183411.rrukznuwmtbwwyjd@ninjato>
Message-ID: <20180404183501.objbi4egz4qdu6hs@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 08:34:11PM +0200, Wolfram Sang wrote:
> On Sun, Mar 25, 2018 at 12:07:46PM +0100, Ard Biesheuvel wrote:
> > This is a cleaned up version of the I2C controller driver for
> > the Fujitsu F_I2C IP, which was never supported upstream, and
> > has now been incorporated into the Socionext SynQuacer SoC.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Removed two empty lines found by 'checkpatch --strict' and applied to
> for-next, thanks!

Again, this applies to v7 of this patchset...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/810cef8a/attachment.sig>
