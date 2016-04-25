From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 23:48:05 +0200
Subject: [PATCH 2/2] drivers: firmware: psci: make two helper functions
 static
In-Reply-To: <1461147628-22844-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1461147628-22844-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1461147628-22844-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <9014396.Tqm30NRfMR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 April 2016 11:20:28 Lorenzo Pieralisi wrote:
> From: Jisheng Zhang <jszhang@marvell.com>
> 
> psci_power_state_loses_context() and psci_power_state_is_valid are only
> used internally now, so make them static.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 

Applied both patches to next/drivers, thanks!

	Arnd
