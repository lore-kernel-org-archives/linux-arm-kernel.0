From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 14 Jul 2015 10:54:25 -0700
Subject: [PATCH] arm64: Define HAVE_ARCH_PIO_SIZE and related symbols.
In-Reply-To: <20150714170408.GS16213@arm.com>
References: <1436823096-24059-1-git-send-email-ddaney.cavm@gmail.com>
 <20150714110039.GC16213@arm.com> <55A53509.4060202@caviumnetworks.com>
 <20150714162955.GR16213@arm.com> <55A53FAC.30103@caviumnetworks.com>
 <20150714170408.GS16213@arm.com>
Message-ID: <55A54CD1.1010509@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2015 10:04 AM, Will Deacon wrote:
> Hi David,
>
> On Tue, Jul 14, 2015 at 05:58:20PM +0100, David Daney wrote:
[...]
> We only get this definition if CONFIG_GENERIC_IOMAP=y. Why is that
> selected?
>

OK, Good question.

The original patch was against 3.18, but  commit 09a5723983e (arm64: Use 
include/asm-generic/io.h) changed some of this, so it may need 
reconsideration.

Let me reevaluate this patch.

Thanks,
David Daney
