From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 5 Apr 2016 16:41:47 -0700
Subject: [PATCH v2 2/5] dmaengine: qcom: bam_dma: clear BAM interrupt
 only if it is rised
In-Reply-To: <1459896982-30171-3-git-send-email-stanimir.varbanov@linaro.org>
References: <1459896982-30171-1-git-send-email-stanimir.varbanov@linaro.org>
 <1459896982-30171-3-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20160405234141.GC11586@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 01:56:19AM +0300, Stanimir Varbanov wrote:

s/rised/raised ?

> Currently we write BAM_IRQ_CLR register with zero even when no
> BAM_IRQ occured. This write has some bad side effects when the
> BAM instance is for the crypto engine. In case of crypto engine
> some of the BAM registers are xPU protected and they cannot be
> controlled by the driver.

-- 
~Vinod
