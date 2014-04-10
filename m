From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Apr 2014 13:36:10 -0400
Subject: [PATCH 2/5] gpio: omap: check gpiochip_add() return value
In-Reply-To: <1396796297-13002-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
 <1396796297-13002-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <5346D68A.2090502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 April 2014 10:58 AM, Javier Martinez Canillas wrote:
> The gpiochip_add() function can fail if the chip cannot
> be registered so the return value has to be checked and
> the error propagated in case it happens.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
