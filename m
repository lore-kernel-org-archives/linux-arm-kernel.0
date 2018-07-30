From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 30 Jul 2018 15:50:04 -0700
Subject: [PATCH v2 2/7] net: phy: Fix the register offsets in Broadcom
 iProc mdio mux driver
In-Reply-To: <1532726613-6483-3-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-3-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <eac0f689-a7b6-69f2-2f96-e7a959b283ce@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2018 02:23 PM, Arun Parameswaran wrote:
> Modify the register offsets in the Broadcom iProc mdio mux to start
> from the top of the register address space.
> 
> Earlier, the base address pointed to the end of the block's register
> space. The base address will now point to the start of the mdio's
> address space. The offsets have been fixed to match this.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
