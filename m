From: vlad.babchuk@gmail.com (Volodymyr Babchuk)
Date: Wed, 31 Aug 2016 20:02:49 +0300
Subject: [PATCH v11 3/4] tee: add OP-TEE driver
In-Reply-To: <1471870856-18684-4-git-send-email-jens.wiklander@linaro.org>
References: <1471870856-18684-1-git-send-email-jens.wiklander@linaro.org>
 <1471870856-18684-4-git-send-email-jens.wiklander@linaro.org>
Message-ID: <88c4207b-9e18-7b39-ec73-7f9716e51c99@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22.08.16 16:00, Jens Wiklander wrote:
> On 31.08.16 16:50, Jerome Forissier wrote:Adds a OP-TEE driver which also can be compiled as a loadable module.
>
> * Targets ARM and ARM64
> * Supports using reserved memory from OP-TEE as shared memory
> * Probes OP-TEE version using SMCs
> * Accepts requests on privileged and unprivileged device
> * Uses OPTEE message protocol version 2 to communicate with secure world
>
> Acked-by: Andreas Dannenberg<dannenberg@ti.com>
> Reviewed-by: Javier Gonz?lez<javier@javigon.com>
> Signed-off-by: Jens Wiklander<jens.wiklander@linaro.org>
>
Tested-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>

patches were tested on Renesas Rcar H3 board.
