From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 8 Dec 2015 14:33:22 +0000
Subject: [PATCH 10/19] mfd: arizona-i2c: Add blank line formatting after
 declaration
In-Reply-To: <1449489032-14374-11-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
 <1449489032-14374-11-git-send-email-lee.jones@linaro.org>
Message-ID: <20151208143322.GE6058@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 11:50:23AM +0000, Lee Jones wrote:
> WARNING: Missing a blank line after declarations
> +       struct arizona *arizona = dev_get_drvdata(&i2c->dev);
> +       arizona_dev_exit(arizona);
> 
> total: 0 errors, 1 warnings, 120 lines checked
> 
> Cc: patches at opensource.wolfsonmicro.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
