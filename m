From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 26 Mar 2015 03:41:32 +0530
Subject: [PATCH v1 1/3] phy: phy-core: allow specifying supply at port
 level
In-Reply-To: <1426886727-537-2-git-send-email-arun.ramamurthy@broadcom.com>
References: <1426886727-537-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1426886727-537-2-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <55133294.4040705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 21 March 2015 02:55 AM, Arun Ramamurthy wrote:
> Multi-port phy's may have per-port power supplies. Let's change phy core
> to first attempt to look up the supply at the port level, and then, if
> not found, check parent device.

Why not just have every port provide the power supply if it needs?
I don't think checking for parent device should be present in the phy-core at
all.

Thanks
Kishon
