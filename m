From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 4 May 2016 13:03:04 +0200
Subject: [PATCH v3 2/2] nvmem: mxs-ocotp: remove nvmem regmap dependency
In-Reply-To: <1462214174-469-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1462214174-469-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1462214174-469-3-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <5729D6E8.8060808@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.05.2016 um 20:36 schrieb Srinivas Kandagatla:
> Regmap raw accessors are bus specific implementations, using regmap raw
> apis in nvmem breaks nvmem providers based on regmap mmio.
> This patch moves to nvmem support in the driver to use callback
> instead of regmap, which is what the nvmem core supports now.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
