From: jerome.forissier@linaro.org (=?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?=)
Date: Tue, 23 Aug 2016 10:38:08 +0200
Subject: [PATCH v11 3/4] tee: add OP-TEE driver
In-Reply-To: <1471870856-18684-4-git-send-email-jens.wiklander@linaro.org>
References: <1471870856-18684-1-git-send-email-jens.wiklander@linaro.org>
 <1471870856-18684-4-git-send-email-jens.wiklander@linaro.org>
Message-ID: <fad411ab-f6c3-371a-b39b-dc5d19dcbd87@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/22/2016 03:00 PM, Jens Wiklander wrote:
> Adds a OP-TEE driver which also can be compiled as a loadable module.
> 
> * Targets ARM and ARM64
> * Supports using reserved memory from OP-TEE as shared memory
> * Probes OP-TEE version using SMCs
> * Accepts requests on privileged and unprivileged device
> * Uses OPTEE message protocol version 2 to communicate with secure world
> 
> Acked-by: Andreas Dannenberg <dannenberg@ti.com>
> Reviewed-by: Javier Gonz?lez <javier@javigon.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---

Tested-by: Jerome Forissier <jerome.forissier@linaro.org> (HiKey)

-- 
Jerome
