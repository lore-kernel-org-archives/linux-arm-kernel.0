From: vkoul@kernel.org (Vinod)
Date: Mon, 2 Jul 2018 17:47:04 +0530
Subject: [PATCH] dma: ste_dma40: Remove VLA usage
In-Reply-To: <20180629185107.GA37488@beast>
References: <20180629185107.GA37488@beast>
Message-ID: <20180702121704.GI22377@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-18, 11:51, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a pre-allocated scratch register space, set up with
> all other other allocations.

Applied after fixing subsystem tag, thanks

-- 
~Vinod
