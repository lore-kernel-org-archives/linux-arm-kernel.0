From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 1 Nov 2017 18:23:22 +0200
Subject: [PATCH v4 1/7] i2c: Switch to using gpiod interface for gpio bus
 recovery
In-Reply-To: <1509435239-64848-2-git-send-email-preid@electromag.com.au>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
 <1509435239-64848-2-git-send-email-preid@electromag.com.au>
Message-ID: <d6f29fd9-1f22-8956-d9c6-aa797aa4340b@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2017 09:33 AM, Phil Reid wrote:
> Currently the i2c gpio recovery code uses gpio integer interface
> instead of the gpiod. This change switch the core code to use
> the gpiod while still retaining compatibility with the gpio integer
> interface. This will allow individual driver to be updated and tested
> individual to switch to using the gpiod interface.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/i2c-core-base.c | 21 +++++++++++++++++----
>   include/linux/i2c.h         |  2 ++
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
