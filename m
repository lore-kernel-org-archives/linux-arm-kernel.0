From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 5 Apr 2016 16:45:52 -0700
Subject: [PATCH v2 4/5] dmaengine: qcom: bam_dma: use correct pipe FIFO
 size
In-Reply-To: <1459896982-30171-5-git-send-email-stanimir.varbanov@linaro.org>
References: <1459896982-30171-1-git-send-email-stanimir.varbanov@linaro.org>
 <1459896982-30171-5-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20160405234551.GE11586@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 01:56:21AM +0300, Stanimir Varbanov wrote:
> The pipe fifo size register must instruct the bam hw
> how many hw descriptors can be pushed to fifo. Currently
> we isntruct the hw with 32KBytes but wrap the tail in
    ^^^^^^^^^
typo 

-- 
~Vinod
