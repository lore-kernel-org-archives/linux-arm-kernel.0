From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Apr 2012 12:33:35 +0100
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <20120427112655.GS28063@b20223-02.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <1335514900.31825.132.camel@vkoul-udesk3>
 <20120427084109.GO28063@b20223-02.ap.freescale.net>
 <1335522130.31825.135.camel@vkoul-udesk3>
 <20120427112655.GS28063@b20223-02.ap.freescale.net>
Message-ID: <20120427113335.GM24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 07:26:56PM +0800, Richard Zhao wrote:
> Sure, I mean, can you doc in include/linux/dmaengine.h that
> dmaengine_prep_xxx may sleep?

Incorrect.  They may _not_ sleep.
