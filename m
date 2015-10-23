From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 23 Oct 2015 13:49:15 +0200
Subject: [PATCH v2 2/2] i2c: uniphier_f: add UniPhier FIFO-builtin I2C
 driver
In-Reply-To: <1445597520-6299-3-git-send-email-yamada.masahiro@socionext.com>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
 <1445597520-6299-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151023114915.GJ13380@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 07:52:00PM +0900, Masahiro Yamada wrote:
> Add support for on-chip I2C controller used on newer UniPhier SoCs
> such as PH1-Pro4, PH1-Pro5, etc.  This adapter is equipped with
> 8-depth TX/RX FIFOs.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/48abc12c/attachment-0001.sig>
