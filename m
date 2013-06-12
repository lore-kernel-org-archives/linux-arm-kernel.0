From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 12 Jun 2013 19:56:54 +0400
Subject: [PATCH 01/15] ARM: clps711x: Remove NEED_MACH_MEMORY_H dependency
In-Reply-To: <20130611225708.GC23774@quad.lixom.net>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
 <20130611225708.GC23774@quad.lixom.net>
Message-ID: <20130612195654.ea0d899c60a4cb1d0c0f0104@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013 15:57:08 -0700
Olof Johansson <olof@lixom.net> wrote:

> On Mon, May 13, 2013 at 09:07:20PM +0400, Alexander Shiyan wrote:
> > This patch removes dependency of NEED_MACH_MEMORY_H for CLPS711X-target.
> > Since some board may have memory holes, define ARCH_HAS_HOLES_MEMORYMODEL
> > for these boards.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Applied both series (3 gpio patches and the 15 other patches).

Thank you very mach Olof, long awaited changes for me,
next series will be step to make clps711x multiplatfom.

-- 
Alexander Shiyan <shc_work@mail.ru>
