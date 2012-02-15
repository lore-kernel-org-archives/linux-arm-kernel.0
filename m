From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 13:56:37 -0800
Subject: [PATCH v2 7/7] ARM: imx: remove macro MXC_GPIO_IRQ_START
In-Reply-To: <20120215201635.GG25779@ponder.secretlab.ca>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
 <1329331668-30325-8-git-send-email-shawn.guo@linaro.org>
 <20120215201635.GG25779@ponder.secretlab.ca>
Message-ID: <20120215215636.GB30946@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 01:16:35PM -0700, Grant Likely wrote:
> On Wed, Feb 15, 2012 at 10:47:48AM -0800, Shawn Guo wrote:
> > Now, macro MXC_GPIO_IRQ_START is referenced nowhere, so remove it.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Series looks okay to me on a brief review.  I'll let Rob pick it up since
> it needs to be based on top of his generic_irq work.  There will still need
> to be some rebasing while I stablize the irq_domain tree, but I'll try to
> do that ASAP.
> 
Thanks for looking at it, Grant.  But it does not work properly with
your irqdomain/next yet.  It requires some little change on irq_domain
side, which is mentioned in another reply to you.

-- 
Regards,
Shawn
