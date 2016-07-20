From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 20 Jul 2016 12:46:17 +0300
Subject: [PATCH V2 3/3] perf tools: adding coresight etm PMU record
 capabilities
In-Reply-To: <1468521344-15047-4-git-send-email-mathieu.poirier@linaro.org>
References: <1468521344-15047-1-git-send-email-mathieu.poirier@linaro.org>
 <1468521344-15047-4-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <578F4869.5070201@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/16 21:35, Mathieu Poirier wrote:
> Coresight ETMs are IP blocks used to perform HW assisted tracing
> on a CPU core.  This patch introduce the required auxiliary API
> functions allowing the perf core to interact with a tracer.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
