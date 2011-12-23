From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Dec 2011 19:14:48 +0000
Subject: [PATCH 07/12] ARM: S5PV210: introduce
 arch/arm/mach-s5pv210/common.[ch]
In-Reply-To: <1324385316-6052-8-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <1324385316-6052-8-git-send-email-kgene.kim@samsung.com>
Message-ID: <20111223191448.GR2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 09:48:31PM +0900, Kukjin Kim wrote:
> This patch introduces common.[ch] which are used only in the
> arch/arm/mach-s5pv210/ directory. The common.c file merges
> the cpu.c and init.c which are used commonly on S5PCV210/S5PC100
> SoC and the common.h local header file replaces with plat/s5pv210.h
> file.

Note that the patch system does _not_ deal in any way with replacing
patch comments.  Comments added against a patch already submitted
to the patch system containing an attributation get _added_ to the
initial comment.

So, it ends up looking like this:

ARM: 7248/1: S5PV210: introduce arch/arm/mach-s5pv210/common.[ch

This patch introduces common.[ch] which are used only in the
arch/arm/mach-s5pv210/ directory. The common.c file merges
the cpu.c and init.c which are used commonly on S5PCV210/S5PC100
SoC and the common.h local header file replaces with plat/s5pv210.h
file.

Comments from Kukjin Kim:

 Subject: [PATCH 04/12] ARM: S5PV210: introduce arch/arm/mach-s5pv210/common.[ch]

 This patch introduces common.[ch] which are used only in the
 arch/arm/mach-s5pv210/ directory. The common.c file merges
 the cpu.c and init.c which are used commonly on S5PCV210/S5PC100
 SoC and the common.h local header file replaces with plat/s5pv210.h
 file.

 ---
 Changes: fixed missing ']' at the end of the subject

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

which I think you can agree is not good.  If you want to _change_ the
initial comments, please resubmit the patch entirely.
