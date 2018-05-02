From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 2 May 2018 15:18:49 +0200
Subject: [PATCH v8 02/12] ARM: sunxi: smp: Move assembly code into a file
In-Reply-To: <20180501123131.7738-3-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-3-mylene.josserand@bootlin.com>
Message-ID: <20180502131849.rwthjkpf7nxojeui@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 02:31:21PM +0200, Myl?ne Josserand wrote:
> Move the assembly code for cluster cache enabling and resuming
> into an assembly file instead of having it directly in C code.
> 
> Remove the CFLAGS because we are using the ARM directive "arch"
> instead.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/322e554d/attachment.sig>
