From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 9 Nov 2016 10:55:04 +0100
Subject: [PATCH v2 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
In-Reply-To: <20161109085946.cmd4ltaxpiojq7il@tarshish>
References: <20161109081431.10115-1-romain.perier@free-electrons.com>
 <20161109081431.10115-2-romain.perier@free-electrons.com>
 <20161109085946.cmd4ltaxpiojq7il@tarshish>
Message-ID: <c68c9d6b-b1e6-5bdd-7725-7c409da2df2d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch

Le 09/11/2016 ? 09:59, Baruch Siach a ?crit :

>> @@ -193,6 +204,8 @@ struct pxa_i2c {
>>  	unsigned char		master_code;
>>  	unsigned long		rate;
>>  	bool			highmode_enter;
>> +	unsigned long		fm_mask;
>> +	unsigned long		hs_mask;
>
> Do you really need 64bit for that?
>
> baruch

Mhhh, good point. No I think that I can use an unsigned int.
I will fix it.

Thanks,
Romain

-- 
Romain Perier, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
