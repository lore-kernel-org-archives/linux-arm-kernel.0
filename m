From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Oct 2015 23:00:39 +0200
Subject: [PATCH 3/3] i2c: uniphier: add bindings for UniPhier I2C
 controllers
In-Reply-To: <1438243942-26401-4-git-send-email-yamada.masahiro@socionext.com>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
 <1438243942-26401-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151022210039.GB1516@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 05:12:22PM +0900, Masahiro Yamada wrote:
> Device Tree bindings for two I2C controllers embedded in
> UniPhier SoCs.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Please split this into two files with filenames matching those of the
drivers. I know they will be very similar but I'd like to keep
consistent.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/05884dd3/attachment.sig>
