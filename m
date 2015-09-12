From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 12 Sep 2015 12:58:44 -0700
Subject: [PATCH 7/7] ARM: dts: brcmstb: add BCM7445 system PM DT nodes
In-Reply-To: <1434672696-13632-8-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
 <1434672696-13632-8-git-send-email-computersforpeace@gmail.com>
Message-ID: <55F483F4.40205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/18/15 17:11, Brian Norris a ?crit :
> Need the aon_pm_l2_intc, aon-ctrl, waketimer, boot SRAM, and
> memory_controller descriptions.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applied to devicetree/next sans the wake-timer node and the now
duplicate aon_pm_l2_intc entry, thanks!
-- 
Florian
