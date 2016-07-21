From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 21 Jul 2016 15:09:35 -0700
Subject: [PATCH v3 2/3] hwmon: xgene: Add hwmon driver
In-Reply-To: <1469134557-26869-3-git-send-email-hotran@apm.com>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
 <1469134557-26869-3-git-send-email-hotran@apm.com>
Message-ID: <20160721220935.GB19236@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 01:55:56PM -0700, Hoan Tran wrote:
> This patch adds hardware temperature and power reading support for
> APM X-Gene SoC using the mailbox communication interface.
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---

[ ... ]

> +
> +	dev_info(&pdev->dev, "APM X-Gene SoC HW monitor driver registered\n");
> +
> +	return rc;
> +

Nitpick: rc == 0 here, so return 0; is a better choice.
Otherwise looks good.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Note that I can not apply the patch at this time due to its dependency.

Guenter
