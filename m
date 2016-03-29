From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 28 Mar 2016 18:31:20 -0700
Subject: [PATCH v2 2/5] phy: Add support for NS2 SATA3 PHY in Broadcom
 SATA3 PHY driver
In-Reply-To: <1459140510-5317-3-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
 <1459140510-5317-3-git-send-email-anup.patel@broadcom.com>
Message-ID: <56F9DAE8.9050204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2016 21:48, Anup Patel a ?crit :
> This patch adds support for Broadcom NS2 SATA3 PHY in existing
> Broadcom SATA3 PHY driver.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>

As mentioned before during the internal review, there is a lot of churn
done here to add NS2 support, which in itself could be a good 2-3
independent preliminary patches. I tested v1 on a 7445 and did not see
any issues with it so and convinced myself your transformation is
correct so:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
