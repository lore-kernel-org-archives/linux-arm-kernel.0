From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 09 Oct 2018 07:59:51 -0700
Subject: [PATCH v3 03/24] drivers/block/z2ram: use ioremap_wt() instead
 of __ioremap(_PAGE_WRITETHRU)
In-Reply-To: <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
Message-ID: <1539097191.64374.44.camel@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-10-09 at 13:51 +0000, Christophe Leroy wrote:
> _PAGE_WRITETHRU is a target specific flag. Prefer generic functions.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Hi Geert,

All patches that have been applied to this driver since 2005 are API refactoring
patches. I haven't found any patches in the history of this driver that seem to
have been submitted by a user of this driver. Do you perhaps know whether anyone
is using this driver?

Thanks,

Bart.
