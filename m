From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Jan 2014 11:59:47 +0000
Subject: [PATCH 1/9] spi: rspi: Add missing clk_disable() calls in error
 and cleanup paths
In-Reply-To: <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
Message-ID: <20140113115947.GL29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 12:13:34PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This doesn't seem to apply to current code, please check and resend.
The fact that there's multiple patch serieses in flight from you for
this driver plus development work (again mostly from you) in git is
probably not helping here...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/17e90256/attachment.sig>
