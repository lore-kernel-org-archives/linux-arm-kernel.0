From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 13 Oct 2015 15:19:25 +0100
Subject: [RFC] arm64: add kc_offset_to_vaddr and kc_vaddr_to_offset macro
In-Reply-To: <1444632779-23369-1-git-send-email-yalin.wang2010@gmail.com>
References: <1444632779-23369-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <20151013141925.GD11573@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 02:52:59PM +0800, yalin wang wrote:
> This patch add kc_offset_to_vaddr() and kc_vaddr_to_offset(),
> the default version doesn't work on arm64, because arm64 kernel address
> is below the PAGE_OFFSET, like module address and vmemmap address are
> all below PAGE_OFFSET address.
> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>

Applied. Thanks.

-- 
Catalin
