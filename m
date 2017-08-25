From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Fri, 25 Aug 2017 17:10:10 +0300
Subject: [PATCH v2 0/9] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
In-Reply-To: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <4f22e64f-8a3c-9ce2-d12d-d3ff2c4108c9@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2017 05:42 PM, Ulf Hansson wrote:
> This series has been tested on an ARM64 Hikey board, which isn't having the
> i2c device attached to the ACPI PM domain. This means that the ACPI changes
> needs to be tested on some relevant Intel SoCs and it's greatly appreciated
> is someone could help out with this, so is of course review comments.
> 
I tested this set on both platforms using drivers/acpi/acpi_lpss.c and 
drivers/mfd/intel-lpss.c and didn't see any issues.

I guess tested-by is not needed yet as details are cooking in ACPI part 
of the set.

-- 
Jarkko
