From: tj@kernel.org (Tejun Heo)
Date: Fri, 5 Feb 2016 12:04:23 -0500
Subject: [PATCH] AHCI: Workaround for ThunderX Errata#22536
In-Reply-To: <1454539065-16891-1-git-send-email-tchalamarla@caviumnetworks.com>
References: <1454539065-16891-1-git-send-email-tchalamarla@caviumnetworks.com>
Message-ID: <20160205170423.GE4401@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Tirumalesh.

On Wed, Feb 03, 2016 at 02:37:45PM -0800, tchalamarla at caviumnetworks.com wrote:
> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> 
> Due to Errata in some versions of ThunderX,
> HOST_IRQ_STAT is neither EDGE nor LEVEL,
> ThunderX needs a special sequence for handling interrupt.
> The patch attempts to satisfy the need.

Please take a look at the following patchset and coordinate with
Suman.

 http://lkml.kernel.org/g/1454620826-22554-2-git-send-email-stripathi at apm.com

Thanks.

-- 
tejun
