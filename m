From: joelf@ti.com (Joel Fernandes)
Date: Mon, 25 Nov 2013 16:25:18 -0600
Subject: [PATCH 5/7] ARM: OMAP4: hwmod: add hwmod data for DES IP
In-Reply-To: <20131125221111.GU10023@atomide.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com>
 <1385415876-12387-6-git-send-email-joelf@ti.com>
 <20131125221111.GU10023@atomide.com>
Message-ID: <5293CE4E.3090401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 04:11 PM, Tony Lindgren wrote:
> * Joel Fernandes <joelf@ti.com> [131125 13:45]:
>> +
>> +static struct omap_hwmod_addr_space omap4_des_addrs[] = {
>> +	{
>> +		.pa_start	= 0x480A4000,
>> +		.pa_end		= 0x481A4000,
>> +		.flags		= ADDR_TYPE_RT
>> +	},
>> +	{ }
>> +};
> 
> Let's not add new address space entries. The address
> space should be already coming from device tree.
> 
Sorry, yes. that's true - I'll drop these.

thanks,

-Joel
