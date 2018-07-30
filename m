From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 30 Jul 2018 15:51:03 -0700
Subject: [PATCH v2 4/7] net: phy: Disable external master access in bcm
 mdio mux driver
In-Reply-To: <1532726613-6483-5-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-5-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <bf2a03e1-f4af-130d-83cb-641e5bcf680d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2018 02:23 PM, Arun Parameswaran wrote:
> Configure the scan control register in the Broadcom iProc
> mdio mux driver to disable access to external master.
> 
> In some SoC's, the scan control register defaults to an incorrect
> value.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
--
Florian
