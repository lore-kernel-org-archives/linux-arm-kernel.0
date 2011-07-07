From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 17:22:18 +0100
Subject: [PATCH v4 00/40] ARM: mm: Add generic macros for declaring
	various CPU structs
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110707162218.GA20403@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 03:27:07PM +0100, Dave Martin wrote:
> This series adds macros for declaring some CPU-related structured
> defined in assembler, and ports the various processors, cache and
> tlb implementations to use the macros.

I think this now looks fine - I don't have time to test it at the moment
600+ messages on the list yesterday (I spent most of yesterday _only_
replying to email), new large patch sets on the list today, and
struggling to test some of these changes...

(It's no wonder people feel that they get ignored - generally if I don't
process things on the day they're sent, I hardly go looking back through
my mailbox... it's only Will's pull request which made me go back and
look at yours.)
