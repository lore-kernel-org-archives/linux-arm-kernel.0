From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Feb 2014 13:26:23 +0000
Subject: [PATCH] arm: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <1391592782-18576-1-git-send-email-vkale@apm.com>
References: <1391592782-18576-1-git-send-email-vkale@apm.com>
Message-ID: <20140205132623.GE7550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 09:33:02AM +0000, Vinayak Kale wrote:
> Add DSB after icache flush to complete the cache maintenance operation.
> 
> Signed-off-by: Vinayak Kale <vkale@apm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
