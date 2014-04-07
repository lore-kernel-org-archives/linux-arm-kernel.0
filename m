From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 7 Apr 2014 13:50:45 -0400
Subject: [PATCH] ARM: dts: keystone: add cell's information to i2c nodes
In-Reply-To: <1396884272-8307-1-git-send-email-grygorii.strashko@ti.com>
References: <1396884272-8307-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <5342E575.60308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 April 2014 11:24 AM, Grygorii Strashko wrote:
> I2C nodes should always have #address-cells and #size-cells defined.
> Hence, ensure that all i2cX nodes have #address-cells and #size-cells
> properties defined.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
Right. BTW, have you seen some issue without this patch ?
Just curious what prompted you to create this patch and whether
it needs to be sent as fix during rc's.

Regards,
Santosh
