From: nm@ti.com (Nishanth Menon)
Date: Mon, 07 Mar 2011 08:22:32 +0530
Subject: [PATCH V3 03/19] OMAP3+: voltage: remove initial voltage
In-Reply-To: <4D738E04.5090207@ru.mvista.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-4-git-send-email-nm@ti.com>
	<4D738E04.5090207@ru.mvista.com>
Message-ID: <4D744870.20909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote, on 03/06/2011 07:07 PM:
>
>> Blindly setting a 1.2V setting
>
>     Hm, seems tautological...
As a non native English speaker, I would like to understand how we could 
improve this. I suppose you mean "Blindly setting 1.2V" is better here. 
Am i correct?

>> in the initial structure may not even
>> match the default voltages stored in the voltage table which are
>> supported for the domain. For example, OMAP3430 core domain does not
>> use 1.2V and ends up generating a warning on the first transition.
[..]

-- 
Regards,
Nishanth Menon
