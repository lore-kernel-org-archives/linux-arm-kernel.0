From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 12 Apr 2016 17:05:56 -0500
Subject: [PATCH v3 6/6] dmaengine: qcom: bam_dma: rename
 BAM_MAX_DATA_SIZE define
In-Reply-To: <1460363923-16296-7-git-send-email-stanimir.varbanov@linaro.org>
References: <1460363923-16296-1-git-send-email-stanimir.varbanov@linaro.org>
 <1460363923-16296-7-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20160412220556.GA24737@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 11:38:43AM +0300, Stanimir Varbanov wrote:
> It seems that the define has not been with acurate name and
> makes confusion while reading the code. The more acurate
> name should be BAM_FIFO_SIZE.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
