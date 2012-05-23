From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 May 2012 14:29:40 -0600
Subject: [PATCH RFC v3 1/3] pinctrl: remove pinctrl_remove_gpio_range
In-Reply-To: <1337779362-31259-1-git-send-email-b29396@freescale.com>
References: <1337779362-31259-1-git-send-email-b29396@freescale.com>
Message-ID: <4FBD48B4.80806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2012 07:22 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The gpio ranges will be automatically removed when the pinctrl
> driver is unregistered.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
