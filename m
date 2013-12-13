From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Dec 2013 13:45:32 +0000
Subject: [PATCH 3/3] swiotlb: Add support for CMA allocations
In-Reply-To: <20131213133717.GD22933@arm.com>
References: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
 <1386634334-31139-4-git-send-email-lauraa@codeaurora.org>
 <1da8f502-0e34-4b54-929e-bcbe40b20b7f@email.android.com>
 <52A66211.6010707@codeaurora.org>
 <83dd58eb-9a44-4b76-aa68-4669b26acab8@email.android.com>
 <20131210102555.GB2338@mudshark.cambridge.arm.com>
 <20131210104231.GB2521@darko.cambridge.arm.com>
 <52AA595B.7090708@codeaurora.org> <20131213133717.GD22933@arm.com>
Message-ID: <20131213134531.GD19177@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 01:37:17PM +0000, Catalin Marinas wrote:
> I was originally hoping that on ARMv8 systems the DMA will be coherent.

Hehe, wishful thinking, I reckon :)

Will
