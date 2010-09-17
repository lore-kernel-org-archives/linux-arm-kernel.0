From: nm@ti.com (Nishanth Menon)
Date: Fri, 17 Sep 2010 11:20:10 -0500
Subject: [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <A24693684029E5489D1D202277BE89447260B287@dlee02.ent.ti.com>
References: <[PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs>
	<1284686973-13993-1-git-send-email-nm@ti.com>
	<A24693684029E5489D1D202277BE89447260B073@dlee02.ent.ti.com>
	<4C93898B.2070606@ti.com>
	<A24693684029E5489D1D202277BE89447260B287@dlee02.ent.ti.com>
Message-ID: <4C93953A.3010702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aguirre, Sergio had written, on 09/17/2010 11:15 AM, the following:
>>>>> diff --git a/include/linux/opp.h b/include/linux/opp.h
>>>>> new file mode 100644
>>>>> index 0000000..94a552b
>>>>> --- /dev/null
>>>>> +++ b/include/linux/opp.h
>>>>> @@ -0,0 +1,136 @@
>>>>> +/*
>>>>> + * Generic OPP Interface
>>>>> + *
>>>>> + * Copyright (C) 2009-2010 Texas Instruments Incorporated.
>>>>> + *   Nishanth Menon
>>>>> + *   Romit Dasgupta <romit@ti.com>
>>>>> + * Copyright (C) 2009 Deep Root Systems, LLC.
>>>>> + *   Kevin Hilman
>>>> Just curious why only Romit's e-mail address is there, and not Kevin's
>>> or
>>>> yours...
>>> personal choice I guess, Romit prefered his email id added Kevin and I
>>> did not.
>> OK. No problem then :)
> 
> Actually, Romit's e-mail address seems to be invalid... Is he still having that address? (OR is he still working in TI? 8-| )
On an internal thread, I am told to remove the email id - so will remove 
Romit's email id and cc from v2 patch.

-- 
Regards,
Nishanth Menon
