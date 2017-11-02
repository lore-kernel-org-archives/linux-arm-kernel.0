From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Thu, 2 Nov 2017 17:23:21 +0200
Subject: [PATCH v5 7/7] i2c: remove legacy integer scl/sda gpio for
 recovery
In-Reply-To: <1509590430-11968-8-git-send-email-preid@electromag.com.au>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509590430-11968-8-git-send-email-preid@electromag.com.au>
Message-ID: <64a65555-2eda-89d7-337b-ec1a8d66743f@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2017 04:40 AM, Phil Reid wrote:
> Remove all reference to code related to using integer based ids for
> scl/sda gpio for bus recovery. All in tree drivers are now using the
> gpio descriptors to specific the required gpios.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/i2c-core-base.c | 78 ++-------------------------------------------
>   include/linux/i2c.h         |  7 +---
>   2 files changed, 3 insertions(+), 82 deletions(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
