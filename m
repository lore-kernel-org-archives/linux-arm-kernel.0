From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 1 Aug 2018 18:39:38 -0700
Subject: [PATCH v4 5/8] net: phy: Use devm api for mdio bus allocation in
 bcm iproc mdio mux
In-Reply-To: <1533171233-14557-6-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533171233-14557-6-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <9bd09f10-895b-23cd-cf42-64a942cd266c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/01/2018 05:53 PM, Arun Parameswaran wrote:
> Use devm_mdiobus_alloc() instead of mdiobus_alloc() in the Broadcom
> iProc mdio mux driver.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
