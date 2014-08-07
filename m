From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Aug 2014 11:27:28 -0600
Subject: [PATCH v5 6/6] clk: Add floor and ceiling constraints to clock
 rates
In-Reply-To: <1407333368-31979-6-git-send-email-tomeu.vizoso@collabora.com>
References: <1407333368-31979-1-git-send-email-tomeu.vizoso@collabora.com>
 <1407333368-31979-6-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <53E3B700.8080706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2014 07:56 AM, Tomeu Vizoso wrote:
> Adds a way for clock consumers to set maximum and minimum rates. This can be
> used for thermal drivers to set ceiling rates, or by misc. drivers to set
> floor rates to assure a minimum performance level.

Patches 5, 6,
Reviewed-by: Stephen Warren <swarren@nvidia.com>
