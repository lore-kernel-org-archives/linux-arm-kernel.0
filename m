From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 31 Oct 2016 09:32:53 -0600
Subject: [PATCH] arm64: mm: fix __page_to_voff definition
In-Reply-To: <20161030143858.vhmnibvvwf5qjvqj@localhost>
References: <1477040326-21260-1-git-send-email-neeraju@codeaurora.org>
 <20161030143858.vhmnibvvwf5qjvqj@localhost>
Message-ID: <20161031153253.u2dpnvfc4pzhuz2h@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2016 at 02:38:58PM +0000, Catalin Marinas wrote:
> On Fri, Oct 21, 2016 at 02:28:46PM +0530, Neeraj Upadhyay wrote:
> > Fix parameter name for __page_to_voff, to match its definition.
> > At present, we don't see any issue, as page_to_virt's caller
> > declares 'page'.
> > 
> > Fixes: 9f2875912dac ("arm64: mm: restrict virt_to_page() to the linear mapping")
> > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> I'll queue this patch for 4.10. Thanks.

I didn't realise that Will sent it already for 4.9-rc3, so I dropped it
from the 4.10 queue.

-- 
Catalin
