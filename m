From: nm@ti.com (Nishanth Menon)
Date: Fri, 17 Sep 2010 10:05:44 -0500
Subject: [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <AANLkTin2fBriymD7p-YfhPL24hMfYttsZBdighCSJxV2@mail.gmail.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<AANLkTin2fBriymD7p-YfhPL24hMfYttsZBdighCSJxV2@mail.gmail.com>
Message-ID: <4C9383C8.4020608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij had written, on 09/17/2010 08:41 AM, the following:
> 2010/9/17 Nishanth Menon <nm@ti.com>:
> 
>> diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
>> index fb742c2..45e9d4a 100644
>> --- a/Documentation/power/00-INDEX
>> +++ b/Documentation/power/00-INDEX
>> @@ -14,6 +14,8 @@ interface.txt
>>        - Power management user interface in /sys/power
>>  notifiers.txt
>>        - Registering suspend notifiers in device drivers
>> +opp.txt
>> +       - Operating Performance Point library
>>  pci.txt
>>        - How the PCI Subsystem Does Power Management
> 
> Hm you add the documentation to the index but not the documentation
> itself (easy slip) would you mind posting it?
ouch.. Sorry.. I realized that I missed adding MAINTAINER entry as 
well.. v2 coming up..

-- 
Regards,
Nishanth Menon
