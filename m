From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Apr 2018 11:27:05 +0100
Subject: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
In-Reply-To: <b2ea9760-cad4-8f30-98ac-86a04c4d42a4@codeaurora.org>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <b2ea9760-cad4-8f30-98ac-86a04c4d42a4@codeaurora.org>
Message-ID: <20180427102705.giwkzgqp43qiptws@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 03:55:08PM +0530, Chintan Pandya wrote:
> Ping...
> 
> On 4/3/2018 1:30 PM, Chintan Pandya wrote:
> > This series of patches are follow up work (and depends on)
> > Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> > panic in ioremap huge pages".

First of all, you'd need to post patches against the latest mainline
(4.17-rcX).

Second, since they depend on another series, we'd have to wait for the
comments on that series to settle.

-- 
Catalin
