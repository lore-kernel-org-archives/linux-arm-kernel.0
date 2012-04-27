From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 12:16:26 -0600
Subject: [PATCH 1/2] pinctrl: support gpio request deferred probing
In-Reply-To: <1335353894-22096-1-git-send-email-b29396@freescale.com>
References: <1335353894-22096-1-git-send-email-b29396@freescale.com>
Message-ID: <4F9AE27A.1020205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 05:38 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> As pinctrl handles, it may be possible the pinctrl gpio ranges
> are still not got registered when user call pinctrl_gpio_request.
> Thus, add defer support for it too.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
