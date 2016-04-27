From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 27 Apr 2016 10:07:46 +0100
Subject: [PATCH V4 11/18] coresight: tmc: adding mode of operation for
 link/sinks
In-Reply-To: <1461708634-6327-12-git-send-email-mathieu.poirier@linaro.org>
References: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
 <1461708634-6327-12-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <57208162.8080908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 23:10, Mathieu Poirier wrote:
> Moving tmc_drvdata::enable to a local_t mode.  That way the
> sink interface is aware of it's orgin and the foundation for
> mutual exclusion between the sysFS and Perf interface can be
> laid out.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
