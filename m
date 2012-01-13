From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 15:46:15 +0000
Subject: [PATCH v2] ARM: setup.c: Fix build warning by removing
 unneeded header file
In-Reply-To: <CAOMZO5A_wN_LyozrE6i01aE0A8-POr8Qm19-GU3F6qt9LOHhrQ@mail.gmail.com>
References: <1325535113-26551-1-git-send-email-festevam@gmail.com>
 <1325536725-28403-1-git-send-email-festevam@gmail.com>
 <20120103154218.GW2914@n2100.arm.linux.org.uk>
 <CAOMZO5A_wN_LyozrE6i01aE0A8-POr8Qm19-GU3F6qt9LOHhrQ@mail.gmail.com>
Message-ID: <20120113154615.GZ1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 01:40:15PM -0200, Fabio Estevam wrote:
> Russell,
> 
> On Tue, Jan 3, 2012 at 1:42 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > I won't apply this until the real problem (missing include in
> > linux/crash_dump.h) is resolved.
> 
> As per your recommendation, I sent a patch to fix the missing include
> in crash_dump.h.
> 
> It appears at Linus' tree as commit 1f536b9e
> (include/linux/crash_dump.h needs elf.h) now.
> 
> Should I submit this patch on your patch tracking system?

Yes please.
