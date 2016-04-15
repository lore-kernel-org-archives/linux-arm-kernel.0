From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 15 Apr 2016 15:55:47 +0530
Subject: [PATCH 2/3] ARM: DTS: da850: disable mdio and eth0 by default
In-Reply-To: <1460586628-25152-3-git-send-email-david@lechnology.com>
References: <1460586628-25152-1-git-send-email-david@lechnology.com>
 <1460586628-25152-3-git-send-email-david@lechnology.com>
Message-ID: <5710C1AB.4040707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 April 2016 04:00 AM, David Lechner wrote:
> All other devices are disabled by default and not all boards will use
> these devices, so these should be disabled too.
> 
> da850-evm.dtb already had status = "okay" for these devices.
> da850-enbw-cmc.dts did not, so they were added.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Looks good to me.

Thanks,
Sekhar
