From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Apr 2012 09:09:16 -0600
Subject: [PATCH v2 1/1] pinctrl: add some error checking for user
 interfaces
In-Reply-To: <1334032894-6012-1-git-send-email-b29396@freescale.com>
References: <1334032894-6012-1-git-send-email-b29396@freescale.com>
Message-ID: <4F844D1C.3090104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 10:41 PM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This patch can avoid kernel oops in case the mux or config
> function is not supported by driver.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
