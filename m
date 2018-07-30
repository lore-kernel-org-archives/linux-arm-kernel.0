From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 30 Jul 2018 15:48:33 -0700
Subject: [PATCH v2 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux
 driver base address
In-Reply-To: <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <a0968023-297f-c2c8-76f8-fa0911f29a17@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2018 02:23 PM, Arun Parameswaran wrote:
> Modify the base address of the Broadcom iProc MDIO mux driver to
> point to the start of the block's register address space.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>


-- 
Florian
