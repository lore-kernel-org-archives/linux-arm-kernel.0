From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 14:13:52 +0200
Subject: [PATCH 1/3] asm-generic: Add renameat2 syscall
In-Reply-To: <1398247687-13453-2-git-send-email-james.hogan@imgtec.com>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
 <1398247687-13453-2-git-send-email-james.hogan@imgtec.com>
Message-ID: <201404231413.53113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014, James Hogan wrote:
> Add the renameat2 syscall to the generic syscall list, which is used by
> the following architectures: arc, arm64, c6x, hexagon, metag, openrisc,
> score, tile, unicore32.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch at vger.kernel.org
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Cc: linux-c6x-dev at linux-c6x.org
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon at vger.kernel.org
> Cc: linux-metag at vger.kernel.org
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux at lists.openrisc.net
> Cc: Chen Liqin <liqin.linux@gmail.com>
> Cc: Lennox Wu <lennox.wu@gmail.com>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>
