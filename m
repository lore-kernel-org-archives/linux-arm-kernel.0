From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 31 Jul 2017 17:19:57 +0200
Subject: [PATCH] i2c: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-26-robh@kernel.org>
References: <20170718214339.7774-26-robh@kernel.org>
Message-ID: <20170731151957.jjq43coqlsql3v2x@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:43:06PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: linux-i2c at vger.kernel.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/401ff1ca/attachment-0001.sig>
