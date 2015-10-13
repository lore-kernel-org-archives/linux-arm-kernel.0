From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 13 Oct 2015 12:19:53 +0100
Subject: [PATCH v2 6/9] dmaengine: st_fdma: Add fdma suspend and resume
 callbacks.
In-Reply-To: <20151007112346.GC4810@vkoul-mobl.iind.intel.com>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-7-git-send-email-peter.griffin@linaro.org>
 <20151007112346.GC4810@vkoul-mobl.iind.intel.com>
Message-ID: <20151013111953.GD30342@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Wed, 07 Oct 2015, Vinod Koul wrote:

> On Fri, Sep 11, 2015 at 03:14:28PM +0100, Peter Griffin wrote:
> > +#define ST_FDMA_PM	(&st_fdma_pm)
> > +#else
> > +#define ST_FDMA_PM	NULL
> > +#endif
> Pls use PM helpers you dont need to do this
> 
Could you point me at the PM helpers you are referring to?

regards,

Peter.
