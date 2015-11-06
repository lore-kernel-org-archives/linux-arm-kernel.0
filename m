From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 6 Nov 2015 08:48:03 -0800
Subject: [PATCH] ARM: keystone_defconfig: Enable SYSTEM V IPC
In-Reply-To: <1446821201-21172-1-git-send-email-ceh@ti.com>
References: <1446821201-21172-1-git-send-email-ceh@ti.com>
Message-ID: <563CD9C3.8030702@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/2015 6:46 AM, Carlos Hernandez wrote:
> System V IPC is required by some LTP tests.
> It is also enabled on omap2plus_defconfig which is the other base
> config used for TI platforms.
>
> Signed-off-by: Carlos Hernandez <ceh@ti.com>
> ---
Looks fine. I will pick this up.

Regards,
Santosh
