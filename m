From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Tue, 27 Dec 2016 16:41:15 +0200
Subject: [PATCH v3 resend] i2c: designware: add reset interface
In-Reply-To: <1482848560-3752-1-git-send-email-zhangfei.gao@linaro.org>
References: <y> <1482848560-3752-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <2cc1faeb-1a1b-76e2-0b12-9918ac42861d@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/27/2016 04:22 PM, Zhangfei Gao wrote:
> Some platforms like hi3660 need do reset first to allow accessing registers
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Ramiro Oliveira <ramiro.oliveira@synopsys.com>
> ---
> rebase to 4.10-rc1
>
>  drivers/i2c/busses/i2c-designware-core.h    |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c | 28 ++++++++++++++++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
