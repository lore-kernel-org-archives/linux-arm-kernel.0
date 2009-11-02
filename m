From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 02 Nov 2009 16:37:43 +0000
Subject: [PATCH] [ARM] fix csum_partial_copy_from_user() fault handler
In-Reply-To: <1256842278.20770.78.camel@qu101.quarc.com>
References: <1256842278.20770.78.camel@qu101.quarc.com>
Message-ID: <1257179863.19092.61.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-29 at 11:51 -0700, Stephan Lachowsky wrote:
> The framepointer setup for csum_partial_copy_from_user() was removed in
> 22acc4e65043d436bc286e6059960fa533e37356.  The fault handler needs to use
> an offset from the stack pointer instead.
> 
> Signed-off-by: Stephan Lachowsky <stephan.lachowsky@maxim-ic.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
