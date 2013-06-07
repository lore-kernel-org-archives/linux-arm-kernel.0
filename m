From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 7 Jun 2013 18:57:37 +0530
Subject: [PATCH V2 1/4] ARM: dts: omap5: Rename omap5-evm to omap5-uevm
In-Reply-To: <51B1CC1A.5090405@ti.com>
References: <1370540919-4339-1-git-send-email-r.sricharan@ti.com>
 <1370540919-4339-2-git-send-email-r.sricharan@ti.com>
 <51B1CC1A.5090405@ti.com>
Message-ID: <51B1DFC9.1040006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 05:33 PM, Benoit Cousson wrote:
> Hi Sricharan,
>
> On 06/06/2013 07:48 PM, Sricharan R wrote:
>> The uevm is the official board supported for the OMAP5 soc
>> in mainline. The uevm has an OMAP5432 with a DDR3 memory.
>> Renaming the board dts file and adding the following cleanups.
> OK, so in fact you are not just renaming the board file, you are using
> the previous board EVM DTS to describe a completely different board.
> You are recycling the old non supported EVM.
>
> You should update the subject and changelog to reflect that, because
> that's rather confusing.
  Ok, reposted V3.
>
>>  * There are no devices connected on I2C 2,3,4 buses. So remove
>>    the pinmux data for the same.
>>
>>  * DDR3 memory is used in the uevm. Neither DVFS or temperature
>>    polling is supported with DDR3. So remove the DDR3 device and
>>    emif nodes.
> You should explain why. I don't think this is obvious for people outside TI.
  Ok, updated this in V3.

Regards,
 Sricharan
