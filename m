From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Jan 2014 16:28:34 +0100
Subject: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
In-Reply-To: <20140108152224.GC15182@katana>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140108152224.GC15182@katana>
Message-ID: <52CD6EA2.1020107@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 16:22, Wolfram Sang wrote:
>> +		new_compat->name =  kstrdup("compatible", GFP_KERNEL);
>> +		new_compat->length =  sizeof("marvell,mv78230-a0-i2c");
>> +		new_compat->value =  kstrdup("marvell,mv78230-a0-i2c",
>> +						GFP_KERNEL);
>> +
> 
> Very minor again: Strange whitespacing after "="
> 
arg I missed it :(

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
