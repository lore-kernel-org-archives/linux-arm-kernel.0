From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jan 2012 13:40:15 -0200
Subject: [PATCH v2] ARM: setup.c: Fix build warning by removing unneeded
 header file
In-Reply-To: <20120103154218.GW2914@n2100.arm.linux.org.uk>
References: <1325535113-26551-1-git-send-email-festevam@gmail.com>
 <1325536725-28403-1-git-send-email-festevam@gmail.com>
 <20120103154218.GW2914@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5A_wN_LyozrE6i01aE0A8-POr8Qm19-GU3F6qt9LOHhrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, Jan 3, 2012 at 1:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I won't apply this until the real problem (missing include in
> linux/crash_dump.h) is resolved.

As per your recommendation, I sent a patch to fix the missing include
in crash_dump.h.

It appears at Linus' tree as commit 1f536b9e
(include/linux/crash_dump.h needs elf.h) now.

Should I submit this patch on your patch tracking system?

Regards,

Fabio Estevam
