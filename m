From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Mon, 30 Jul 2018 15:50:25 -0700
Subject: [PATCH v2 3/7] arm64: dts: Fix the base address of the Broadcom
 iProc mdio mux
In-Reply-To: <1532726613-6483-4-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-4-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <6139b5ad-32a9-4a63-1d6c-4a986c48fad4@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2018 02:23 PM, Arun Parameswaran wrote:
> Modify the base address of the mdio mux driver to point to the
> start of the mdio mux block's register address space.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
