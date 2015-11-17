From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue, 17 Nov 2015 09:38:47 +0100 (CET)
Subject: [PATCH] ARM: sunxi: Re-enable SID driver in multi_v7_defconfig
In-Reply-To: <20151117080754.GF17829@x1>
References: <1447724947-4851-1-git-send-email-public_timo.s@silentcreek.de><20151117080754.GF17829@x1>
Message-ID: <20151117083847.6EF486C80816@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Lee Jones schrieb am 17.11.2015 09:07:

> On Tue, 17 Nov 2015, Timo Sigurdsson wrote:
> 
>> Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
>> framework") moved the the sunxi SID driver to a new framework, but left
>> multi_v7_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
>> instead of the new symbold NVMEM_SUNXI_SID. Hence, re-enable the driver
>> in multi_v7_defconfig.
>> 
>> While at it, clean up multi_v7_defconfig by generating a fresh file via
>>   make multi_v7_defconfig
>>   make savedefconfig
>> While this moves around a few lines and removes unnecessary symbols,
>> it doesn't introduce any functional changes.
>> 
>> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> 
> Please either use Git to submit your changes, or add a diffstat in
> manually.  They *are* helpful.

I do use git. But I guess I messed up the command somehow so the diffstat
wasn't included. Sorry about that. I'll make sure it's there next time.


Thanks,

Timo


[...]
<snip>
