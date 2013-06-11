From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 15:57:08 -0700
Subject: [PATCH 01/15] ARM: clps711x: Remove NEED_MACH_MEMORY_H dependency
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130611225708.GC23774@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 09:07:20PM +0400, Alexander Shiyan wrote:
> This patch removes dependency of NEED_MACH_MEMORY_H for CLPS711X-target.
> Since some board may have memory holes, define ARCH_HAS_HOLES_MEMORYMODEL
> for these boards.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied both series (3 gpio patches and the 15 other patches).


-Olof
