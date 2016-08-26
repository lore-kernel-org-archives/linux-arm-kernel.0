From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 26 Aug 2016 10:38:25 +0100
Subject: [GIT PULL] SCPI/Vexpress fixes for v4.8-rc
In-Reply-To: <20160826001143.GD6209@localhost>
References: <f232ba19-e359-3ef4-cce5-e76b0f35d078@arm.com>
 <20160826001143.GD6209@localhost>
Message-ID: <27e8a782-ae03-aed5-59d4-c3910d48618f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/08/16 01:11, Olof Johansson wrote:
> Hi Sudeep,
>
> On Tue, Aug 16, 2016 at 12:01:00PM +0100, Sudeep Holla wrote:
>>
>> Hi ARM-SoC guys,
>>
>> I have couple of missing of_node_put fixes in vexpress/scpi drivers.
>> I am not sure if these are considered as more cleanup patches rather
>> than fixes as OF reference counting is not something religiously checked
>> always. Let me know, I will move these to v4.9 queue otherwise.
>>
>> --
>> Regards,
>> Sudeep
>>
>> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
>>
>>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
>> tags/vexpress-fixes-4.8-rc
>>
>> for you to fetch changes up to b079bd555f6060cd6b435a1eb58ec3b8d255ebd0:
>>
>>   firmware: arm_scpi: add missing of_node_put after calling of_parse_phandle
>> (2016-08-08 14:31:09 +0100)
>>
>> ----------------------------------------------------------------
>> SCPI/Vexpress fixes for v4.8-rc
>>
>> Couple of minor fixes to add missing of_node_put after calling
>> of_parse_phandle in SCPI and vexpress-config bus drivers(Peter Chen)
>
> This tag is signed with a key that I can't find any track of anywhere. The
> 32-bit ID is 317EE298.

Sorry for the issues you faced. 317EE298 is one of the subkey ID I have
and I think I have always used it to sign. I don't remember changing
anything recently.

> but the key you have on the servers is 0x39CFD4755FE2D5B4. What's going on?
>

And yes the above one is the main key ID.

> After looking at the contents, it's harmless enough so I've stilled merged
> it but please sort out your keys.
>

I tried experimenting by forcing git to use the main key ID to sign, but
it seem to always pick up the subkey :(.

-- 
Regards,
Sudeep
