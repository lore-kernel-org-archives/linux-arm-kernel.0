From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Mar 2014 11:18:38 +0000
Subject: [PATCH v7 00/15] uprobes: Add uprobes support for ARM
In-Reply-To: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
References: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
Message-ID: <20140308111838.GV21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 03:10:25PM -0500, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> This patch series adds basic uprobes support to ARM. It is based on patches
> developed earlier by Rabin Vincent. That approach of adding hooks into
> the kprobes instruction parsing code was not well received. This approach
> separates the ARM instruction parsing code in kprobes out into a separate set
> of functions which can be used by both kprobes and uprobes. Both kprobes and
> uprobes then provide their own semantic action tables to process the results of
> the parsing.

When you eventually get around to resubmitting this (with all the acks)
please submit as a git pull, rather than a series of patches.  Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
