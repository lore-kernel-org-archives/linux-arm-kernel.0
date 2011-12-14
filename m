From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Dec 2011 13:55:13 +0000
Subject: [PATCH v4 REPOST 4/5] highbank: Unconditionally require l2x0 L2
 cache controller support
In-Reply-To: <4EE8A69C.40304@gmail.com>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-5-git-send-email-dave.martin@linaro.org>
 <4EE8A69C.40304@gmail.com>
Message-ID: <20111214135513.GC2568@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 07:37:32AM -0600, Rob Herring wrote:
> 
> On 12/14/2011 05:39 AM, Dave Martin wrote:
> > If running in the Normal World on a TrustZone-enabled SoC, Linux
> > does not have complete control over the L2 cache controller
> > configuration.  The kernel cannot work reliably on such platforms
> > without the l2x0 cache support code built in.
> > 
> > This patch unconditionally enables l2x0 support for the Highbank
> > SoC.
> > 
> > Thanks to Rob Herring for this suggestion. [1]
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html
> 
> Doesn't this need to be above the SOB? Otherwise:

You may be right ... certainly I see no reason _not_ to change it.
So I'll change it.

> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks

---Dave
