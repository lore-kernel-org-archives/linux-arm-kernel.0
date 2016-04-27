From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 27 Apr 2016 10:08:35 +0100
Subject: [PATCH V4 12/18] coresight: tmc: dump system memory content only
 when needed
In-Reply-To: <1461708634-6327-13-git-send-email-mathieu.poirier@linaro.org>
References: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
 <1461708634-6327-13-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <57208193.8050903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 23:10, Mathieu Poirier wrote:
> Calling tmc_etf/etr_dump_hw() is required only when operating from
> sysFS.  When working from Perf, the system memory is harvested
> from the AUX trace API.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
