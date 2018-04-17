From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 17 Apr 2018 12:56:42 +0300
Subject: [PATCH] coresight: Moving framework and drivers to SPDX identifier
In-Reply-To: <1523911862-29218-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523911862-29218-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180417095642.qrtf3gpotxxsikle@um.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 02:51:02PM -0600, Mathieu Poirier wrote:
> Moving all kernel side CoreSight framework and drivers to SPDX identifier.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

This reminds me: there's drivers/hwtracing/stm/ftrace.c that I didn't
convert during the previous round, do you want to do it or should I?

Thanks,
--
Alex
