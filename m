From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 17 Mar 2017 23:25:23 +0800
Subject: [PATCH v4 2/7] coresight: of_get_coresight_platform_data: Add
 missing of_node_put
In-Reply-To: <574d8e6b-cd2d-c1be-6c14-09e8be147e93@arm.com>
References: <1489762943-25849-1-git-send-email-leo.yan@linaro.org>
 <1489762943-25849-3-git-send-email-leo.yan@linaro.org>
 <574d8e6b-cd2d-c1be-6c14-09e8be147e93@arm.com>
Message-ID: <20170317152523.GC2020@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 03:09:23PM +0000, Suzuki K Poulose wrote:
> On 17/03/17 15:02, Leo Yan wrote:
> >From: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> >The of_get_coresight_platform_data iterates over the possible CPU nodes
> >to find a given cpu phandle. However it does not drop the reference
> >to the node pointer returned by the of_get_coresight_platform_data.
> >
> >[Leo: minor tweaks for of_get_coresight_platform_data]
> >
> >Cc: Leo Yan <leo.yan@linaro.org>
> >Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> You should add your Signed-off-by here when you send somebody's patch, irrespective
> of whether you have modified it or not.
> e.g:
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> [Leo: minor tweaks for of_get_coresight_platform_data]
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks for pointing out this. Will follow up later.

[...]

Thanks,
Leo Yan
