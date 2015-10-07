From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 7 Oct 2015 12:23:48 +0100
Subject: [PATCH v2 6/9] dmaengine: st_fdma: Add fdma suspend and resume
 callbacks.
In-Reply-To: <1441980871-24475-7-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-7-git-send-email-peter.griffin@linaro.org>
Message-ID: <20151007112346.GC4810@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:14:28PM +0100, Peter Griffin wrote:
> +#define ST_FDMA_PM	(&st_fdma_pm)
> +#else
> +#define ST_FDMA_PM	NULL
> +#endif
Pls use PM helpers you dont need to do this

-- 
~Vinod
