From: davidb@codeaurora.org (David Brown)
Date: Fri, 14 Sep 2012 22:16:02 -0700
Subject: [PATCH 12/24] ARM: msm: use __iomem pointers for MMIO
In-Reply-To: <5053B1C9.10103@codeaurora.org>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-13-git-send-email-arnd@arndb.de>
 <5053B1C9.10103@codeaurora.org>
Message-ID: <20120915051602.GA7930@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 03:38:01PM -0700, Stephen Boyd wrote:
> On 09/14/12 14:34, Arnd Bergmann wrote:
> > ARM is moving to stricter checks on readl/write functions,
> > so we need to use the correct types everywhere.
> >
> > Cc: David Brown <davidb@codeaurora.org>
> > Cc: Daniel Walker <dwalker@fifo99.com>
> > Cc: Bryan Huntsman <bryanh@codeaurora.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I was going to send this patch out today. Thanks.
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
