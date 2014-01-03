From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Jan 2014 20:31:57 +0100
Subject: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <20140103194929.706f93c6@skate>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-3-git-send-email-gregory.clement@free-electrons.com>
 <20140103194929.706f93c6@skate>
Message-ID: <52C7102D.60401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2014 19:49, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri,  3 Jan 2014 10:59:45 +0100, Gregory CLEMENT wrote:
> 
>> +		/*
>> +		 * Only revison more recent than A0 support offload
> 
> revison -> revisions
> 
> offload mechanism -> the offload mechanism
> 
>> +		 * mechanism. In case we can't get the SoC revision
>> +		 * weplay safe and we don't enable it
> 
> weplay -> we play
> 
>> +		 */
>> +		if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
>> +			drv_data->offload_enabled = true;
>>  	}
>>  
>>  out:
> 

These typos will be fixed in the next version.

> Thanks!
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
