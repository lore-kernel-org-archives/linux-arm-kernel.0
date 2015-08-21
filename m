From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Aug 2015 10:00:43 +0100
Subject: [PATCH] arm64: enable generic idle loop
In-Reply-To: <1440128422-4170-1-git-send-email-leo.yan@linaro.org>
References: <1440128422-4170-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20150821090043.GA14072@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 11:40:22AM +0800, Leo Yan wrote:
> Enable generic idle loop for ARM64, so can support for hlt/nohlt
> command line options to override default idle loop behavior.

Just curious, what do you need this for?

-- 
Catalin
