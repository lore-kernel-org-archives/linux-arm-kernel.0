From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2015 18:36:57 +0000
Subject: [PATCH] arm64/mm: use PAGE_ALIGNED instead of IS_ALIGNED
In-Reply-To: <1445858817-7056-1-git-send-email-kuleshovmail@gmail.com>
References: <1445858817-7056-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <20151028183656.GE8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 05:26:57PM +0600, Alexander Kuleshov wrote:
> The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
> use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>

Queued for 4.4. Thanks.

-- 
Catalin
