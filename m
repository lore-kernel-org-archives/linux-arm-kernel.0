From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Feb 2014 10:52:24 +0000
Subject: [PATCH RESEND] arm: add DSB after icache flush in
 __flush_icache_all()
In-Reply-To: <1392109811-8525-1-git-send-email-vkale@apm.com>
References: <1392109811-8525-1-git-send-email-vkale@apm.com>
Message-ID: <20140211105224.GC3748@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:10:11AM +0000, Vinayak Kale wrote:
> Add DSB after icache flush to complete the cache maintenance operation.
> 
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I guess what you need to do is add:

Cc: <stable@vger.kernel.org>

and send the patch to Russell's patch system (and add any other acks you
may get in the meantime).

-- 
Catalin
