From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 19 Jul 2011 14:48:03 +0530
Subject: [PATCH v2] ARM: davinci: Check for NULL return from
	irq_alloc_generic_chip
In-Reply-To: <1310881175-26182-1-git-send-email-toddpoynor@google.com>
References: <1310881175-26182-1-git-send-email-toddpoynor@google.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DBDC6C1@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 17, 2011 at 11:09:35, Todd Poynor wrote:
> Avoid NULL dereference of irq_alloc_generic_chip return in low
> memory conditions.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Thanks Todd, queuing this for v3.0.

Thanks,
Sekhar
