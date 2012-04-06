From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Apr 2012 09:32:14 -0600
Subject: [PATCH 1/1] pinctrl: fix pinmux_check_ops error checking
In-Reply-To: <1333714689-22450-1-git-send-email-b29396@freescale.com>
References: <1333714689-22450-1-git-send-email-b29396@freescale.com>
Message-ID: <4F7F0C7E.6030407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2012 06:18 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Do not use get_functions_count before checking.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

IIRC, Viresh added some other get_*_count() functions in the same patch.
Do we need any more fixes similar to the this for those too?
