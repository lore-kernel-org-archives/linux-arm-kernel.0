From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 3 Feb 2012 11:27:58 +0000
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <1327912567-18966-2-git-send-email-bill4carson@gmail.com>
References: <1327912567-18966-1-git-send-email-bill4carson@gmail.com>
 <1327912567-18966-2-git-send-email-bill4carson@gmail.com>
Message-ID: <20120203112758.GA14008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 08:36:07AM +0000, bill4carson at gmail.com wrote:
> From: Bill Carson <bill4carson@gmail.com>
> 
> If we are only about to clear a hardware pte entry, then pte makeup code is
> unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just skip it.
> 
> Signed-off-by: Bill Carson <bill4carson@gmail.com>

I'll give similar answer to Uwe - the patch looks fine but I haven't
tested or run any benchmarks to tell whether it's worth.

Anyway,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
