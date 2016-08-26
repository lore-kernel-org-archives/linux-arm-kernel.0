From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 26 Aug 2016 14:35:20 -0400
Subject: [PATCH v2 6/7] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2 board
In-Reply-To: <0a6dffe0-8508-724e-c831-d14c32f8cd64@osg.samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-7-git-send-email-cw00.choi@samsung.com>
 <0a6dffe0-8508-724e-c831-d14c32f8cd64@osg.samsung.com>
Message-ID: <f6b8a04e-0bb0-59d8-55c7-7aa04d284e48@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2016 02:30 PM, Javier Martinez Canillas wrote:

[snip]

>> +
>> +			buck3_reg: BUCK3 {
>> +				regulator-name = "VDD_KFC_1.0V_AP";
> 
> Same, maybe using "VDD_APL_1.0V_AP" since the big cluster is Apollo?
> 

I meant s/big/LITTLE here of course, sorry for the typo.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
