From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 17 Nov 2010 13:11:06 +0900
Subject: [PATCH v4] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <1289919848-23262-1-git-send-email-plagnioj@jcrosoft.com>
References: <1289919848-23262-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20101117041106.GC2790@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 04:04:08PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> factorise some generic infrastructure to assist looking up struct clks
> for the ARM & SH architecture.
> 
> as the code is identical at 99%
> 
> put the arch specific code for allocation as example in asm/clkdev.h
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Paul Mundt <lethal@linux-sh.org>

I've you've finally addressed Russell's comments and nothing else has
changed, then you should just resubmit the updated version to the patch
tracker.
