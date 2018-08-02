From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 1 Aug 2018 18:40:06 -0700
Subject: [PATCH v4 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <1533171233-14557-8-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533171233-14557-8-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <a63d5c49-3657-c8f8-ce86-6c775a51de24@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/01/2018 05:53 PM, Arun Parameswaran wrote:
> Add support to configure the internal rate adjust register based on the
> core clock supplied through device tree in the Broadcom iProc mdio mux.
> 
> The operating frequency of the mdio mux block is 11MHz. This is derrived
> by dividing the clock to the mdio mux with the rate adjust register.
> 
> In some SoC's the default values of the rate adjust register do not yield
> 11MHz. These SoC's are required to specify the clock via the device tree
> for proper operation.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
