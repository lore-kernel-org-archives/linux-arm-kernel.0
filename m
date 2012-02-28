From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Feb 2012 10:03:33 -0300
Subject: [PATCH] ARM: mx51: Fix build error due to missing include of
 <linux/bug.h>
In-Reply-To: <20120228125336.GA3617@n2100.arm.linux.org.uk>
References: <1330431110-22020-1-git-send-email-fabio.estevam@freescale.com>
 <20120228125336.GA3617@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5ByrmWHYnahEm7PN=AxM2LygtytW5XRwUKMbngDUhKshA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 9:53 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I think having the asm/bug.h replaced with linux/bug.h in linux/kernel.h
> would be a better solution.

commit 6f863554 (kernel.h: doesn't explicitly use bug.h, so don't
include it. ), which appears in linux-next, has removed asm/debug.h
from linux/kernel.h.

I should have pointed this commit ID in my commit log.

Regards,

Fabio Estevam
