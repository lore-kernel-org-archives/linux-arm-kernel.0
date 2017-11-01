From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 1 Nov 2017 18:22:11 +0200
Subject: [PATCH v4 4/7] i2c: designware: add i2c gpio recovery option
In-Reply-To: <1509435239-64848-5-git-send-email-preid@electromag.com.au>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
 <1509435239-64848-5-git-send-email-preid@electromag.com.au>
Message-ID: <f13c736e-324e-087d-f191-a7d4966688d9@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2017 09:33 AM, Phil Reid wrote:
> From: Tim Sander <tim@krieglstein.org>
> 
> This patch contains much input from Phil Reid and has been tested
> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
> SCL and SDA GPIO's.
> 
> Signed-off-by: Tim Sander <tim@krieglstein.org>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/busses/i2c-designware-common.c |  6 +++-
>   drivers/i2c/busses/i2c-designware-core.h   |  1 +
>   drivers/i2c/busses/i2c-designware-master.c | 57 ++++++++++++++++++++++++++++++
>   3 files changed, 63 insertions(+), 1 deletion(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
