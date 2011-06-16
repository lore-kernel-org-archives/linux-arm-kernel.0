From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 16 Jun 2011 11:56:03 +0200
Subject: [RFC] Add Arm cpu topology definition
In-Reply-To: <20110616094737.GB5583@const.bordeaux.inria.fr>
References: <BANLkTinRGRUxKB=C_2Y2F93czWScEUo+Jw@mail.gmail.com>
	<20110616085547.GH4935@const.famille.thibault.fr>
	<BANLkTinxz1T7uPAS0u=gth3hAh+SFQkTQQ@mail.gmail.com>
	<20110616094737.GB5583@const.bordeaux.inria.fr>
Message-ID: <BANLkTin2F-sJNjrMhTTqrh0J3ej9OVvQxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 June 2011 11:47, Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> Vincent Guittot, le Thu 16 Jun 2011 11:44:30 +0200, a ?crit :
>> The output of hwloc-gather-topology is :
>>
>> Machine (phys=0 local=280840KB total=280840KB)
>> ? Socket #0 (phys=3)
>> ? ? Core #0 (phys=0)
>> ? ? ? PU #0 (phys=0)
>> ? ? Core #1 (phys=1)
>> ? ? ? PU #1 (phys=1)
>> depth 0: ? ? ? ?1 Machine (type #1)
>> ?depth 1: ? ? ? 1 Socket (type #3)
>> ? depth 2: ? ? ?2 Cores (type #5)
>> ? ?depth 3: ? ? 2 PUs (type #6)
>> Topology not from this system
>>
>> let me know if it's what you want
>
> This looks good for a bicore socket, yes. ?Could you send me the tarball
> it created, so we can include it in the hwloc testsuite?
>

yes, I will send it to you

> Do you have a example with smt cores?

no, I haven't

>
> Samuel
>
