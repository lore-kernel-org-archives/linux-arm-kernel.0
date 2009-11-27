From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2009 20:05:21 +0000
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009F89684D7F09@IL-MB01.marvell.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<FCBE654890C0334289D0AD3AF4EF009F89684D7F09@IL-MB01.marvell.com>
Message-ID: <20091127200521.GC28193@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 12:28:42AM +0200, Saeed Bishara wrote:
>     For some reason, my previous email didn't reach the mailing list.
>     Here is the patch as an attachment with some minor updates (replaced
> mach/gpio.h to linux/gpio.h)

Also #include <asm/io.h> and (any) #include <mach/io.h> -> linux/io.h please.
