From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 09:41:04 +0100
Subject: [PATCH] ARM: mach-footbridge: add missing header file
	<video/vga.h>
In-Reply-To: <CAK5ve-+0rtcC8KiEW9=WHnW8nPTr8+7tmnqUgZJQ_3GV6gMpzw@mail.gmail.com>
References: <1313575204-25374-1-git-send-email-bryan.wu@canonical.com>
	<CAK5ve-+0rtcC8KiEW9=WHnW8nPTr8+7tmnqUgZJQ_3GV6gMpzw@mail.gmail.com>
Message-ID: <20110821084104.GC12028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 12:37:09PM +0800, Bryan Wu wrote:
> Russell,
> 
> Also this one. any comment?

Other than frustration that Rob Herring isn't responding to his breakage
(which is making me want to ignore further patches from Rob - clearly
doesn't care about the effect of his c9d95fb "ARM: convert PCI defines
to variables" patch...)

It looks obviously correct.
