From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 2 Jun 2016 11:10:33 -0700
Subject: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
In-Reply-To: <575027E9.3070202@ti.com>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <3593753.UuDg5ybrvm@wuerfel>
 <cdbd2482-de98-569b-7ff0-c8963037de53@oracle.com> <575027E9.3070202@ti.com>
Message-ID: <58a082cf-9936-0b04-6d4a-82c724c02e73@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/2/2016 5:34 AM, Nishanth Menon wrote:
> On 06/01/2016 06:26 PM, Santosh Shilimkar wrote:
> [...]
>>>> Side note on LPAE:
>>>> For our current device tree and u-boot, LPAE is mandatory to bootup
>>>> for current Keystone boards - but this is not a SoC requirement,
>>>> booting without LPAE/HIGHMEM results in non-coherent DDR accesses.
>>>
>>> This sounds like a regression, I thought we had this working when
>>> keystone was initially merged and we got both the coherent and
>>> non-coherent mode working with the same DT.
>>>
>> Yes and it works. The coherent memory space itself is beyond 4GB so
>
> Hmm... True, I just tested next-20160602 with mem_lpae set to 0 in
> u-boot and it seems to boot just fine.
>
>> I don't understand a requirement of having coherent memory without
>> LPAE.
>
> Looks like a messed up description on my end, Looks like I have to
> update my automated test framework to incorporate the manual steps
> involved.
>
No worries. Am glad you got your setup working.

Regards,
Santosh
