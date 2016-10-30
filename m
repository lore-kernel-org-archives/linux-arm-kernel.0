From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 30 Oct 2016 14:38:58 +0000
Subject: [PATCH] arm64: mm: fix __page_to_voff definition
In-Reply-To: <1477040326-21260-1-git-send-email-neeraju@codeaurora.org>
References: <1477040326-21260-1-git-send-email-neeraju@codeaurora.org>
Message-ID: <20161030143858.vhmnibvvwf5qjvqj@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 02:28:46PM +0530, Neeraj Upadhyay wrote:
> Fix parameter name for __page_to_voff, to match its definition.
> At present, we don't see any issue, as page_to_virt's caller
> declares 'page'.
> 
> Fixes: 9f2875912dac ("arm64: mm: restrict virt_to_page() to the linear mapping")
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

I'll queue this patch for 4.10. Thanks.

-- 
Catalin
