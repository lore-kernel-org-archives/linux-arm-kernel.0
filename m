From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 6 Nov 2018 09:21:51 +0000
Subject: [PATCH 1/3] coresight: etb10: Add support for CLAIM tag
In-Reply-To: <1541456790-28282-2-git-send-email-mathieu.poirier@linaro.org>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
 <1541456790-28282-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <39da792f-4197-21f9-74ae-d4c1658150a8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On 05/11/2018 22:26, Mathieu Poirier wrote:
> Following in the footstep of what was done for other CoreSight devices,
> add CLAIM tag support to ETB10 in order to synchronise access to the
> HW between the kernel and an external agent.
> 

Thanks for spotting this. Somehow I missed the etb10 in the original
series.

> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
