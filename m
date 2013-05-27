From: dt.tangr@gmail.com (Daniel Tang)
Date: Mon, 27 May 2013 14:07:05 +1000
Subject: [RFC PATCHv4 1/6] arm: TI-Nspire platform code
In-Reply-To: <201305262246.12803.arnd@arndb.de>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <1369480087-24786-2-git-send-email-dt.tangr@gmail.com>
 <201305262246.12803.arnd@arndb.de>
Message-ID: <3ED6FFF2-89E2-4426-8DDC-10B4E6C79F26@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27/05/2013, at 6:46 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> 
>> +	{
>> +		.virtual	=  NSPIRE_PWR_VIRT_BASE,
>> +		.pfn		= __phys_to_pfn(NSPIRE_PWR_PHYS_BASE),
>> +		.length		= SZ_4K,
>> +		.type		= MT_DEVICE
>> +	}
>> +};
> 
> And I think this one can be replaced with a call to of_iomap:

Does of_iomap work that early in the boot process?

Cheers,
Daniel Tang
