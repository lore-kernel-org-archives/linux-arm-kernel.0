From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 Aug 2018 11:17:42 +0100
Subject: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180801215733.4dfa3a95@bbrezillon>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
 <20180801172747.GJ5509@sirena.org.uk>
 <20180801215733.4dfa3a95@bbrezillon>
Message-ID: <20180802101742.GF9117@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 09:57:33PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> 2/ Getting this patch [1] merged and implementing the ->get_name() hook
>    in this driver so that SPI NOR devs declared to the MTD layer keep
>    the same name after the transition to spi-mem and mtdparts= passed on
>    the cmdline keep working. Without this in place we're likely to
>    break a few setups :-/.

> [1]https://patchwork.kernel.org/patch/10508693/ 

I don't seem to have a copy of this patch...  not sure it was sent to
me?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180802/8482e63d/attachment.sig>
