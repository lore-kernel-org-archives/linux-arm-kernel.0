From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 15:19:15 +0000
Subject: [RFC][PATCH] ARM: ptrace: remove single-step emulation code
In-Reply-To: <1295449635-4292-1-git-send-email-will.deacon@arm.com>
References: <1295449635-4292-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110119151915.GG31652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 03:07:15PM +0000, Will Deacon wrote:
> I'm posting this as an RFC to see if anybody has a good reason to keep this
> code around. There's also a chance I've missed an opportunity to remove some
> related code, but I think I found everything. Tested on a Versatile Express,
> single-stepping in GDB worked fine.

Have you checked whether strace and ltrace use single stepping?
