From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 06 Aug 2013 10:02:50 +0100
Subject: [PATCH v3 05/16] ARM: mvebu: remove device tree parsing for cpu
 nodes
In-Reply-To: <5200B2E9.8090009@free-electrons.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51FA3064.9080502@arm.com> <20130801120256.GW5882@titan.lakedaemon.net>
 <51FFD2B1.70509@arm.com> <5200B2E9.8090009@free-electrons.com>
Message-ID: <5200BBBA.7020303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/13 09:25, Gregory CLEMENT wrote:
> On 05/08/2013 18:28, Sudeep KarkadaNagesha wrote:
>> On 01/08/13 13:02, Jason Cooper wrote:
>>> Sudeep,
>>>
>>> On Thu, Aug 01, 2013 at 10:54:44AM +0100, Sudeep KarkadaNagesha wrote:
>>>> On 22/07/13 12:32, Sudeep KarkadaNagesha wrote:
>>>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>>>
>>>>> Currently set_secondary_cpus_clock assume the CPU logical ordering
>>>>> and the MPDIR in DT are same, which is incorrect.
>>>>>
>>>>> Since the CPU device nodes can be retrieved in the logical ordering
>>>>> using the DT helper, we can remove the devices tree parsing.
>>>>>
>>>>> This patch removes DT parsing by making use of of_get_cpu_node.
>>>>>
>>>>> Cc: Gregory Clement <gregory.clement@free-electrons.com>
>>>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>>>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>>
>>>> Hi Gregory/Andrew/Jason,
>>>>
>>>> Does this change look fine for mvebu?
>>>> If yes, can I have your ACKs ?
>>>
>>> Gregory is the one best suited to review/Ack this.  He'll be back on
>>> Monday.
>>>
>> Hi Gregory,
>>
>> Can you please review this patch ?
> 
> Your patch is a nice improvement, I reviewed it and I also tested it on the
> Armada XP DB board.
> 
> You can add my:
> Acked-by: Gregory Clement <gregory.clement@free-electrons.com>

Thanks Gregory.

Regards,
Sudeep
