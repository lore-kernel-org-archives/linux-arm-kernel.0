From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2017 14:14:35 +0000
Subject: [PATCH V9 0/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <266105963441d1cdddeaf40c4b78c239@codeaurora.org>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <16e3b40407e8072dd5b15bf7e65afb18@codeaurora.org>
 <CAJZ5v0h_v-iER5Fffdoczj4CAhetGYqOfJOhdO561_kNCnsEFg@mail.gmail.com>
 <266105963441d1cdddeaf40c4b78c239@codeaurora.org>
Message-ID: <8587b5ab-59b1-feb7-09d9-7ade6d433a4c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/17 14:07, Agustin Vega-Frias wrote:
> Hi Rafael,
> 
> On 2017-01-03 16:56, Rafael J. Wysocki wrote:
>> On Tue, Jan 3, 2017 at 4:19 PM, Agustin Vega-Frias
>> <agustinv@codeaurora.org> wrote:
>>> Hi,
>>>
>>> Is there any more feedback on this beyond Lorenzo's suggestion to drop
>>> the conditional check on the first patch?
>>> How can we move forward on this series?
>>
>> Essentially, I need to convince myself that patches [1-2/3] are fine
>> which hasn't happened yet.
> 
> Pinging again. Do you have any questions that might help with your
> review? I have some minor changes I have to make to the driver itself
> (patch 3) and I'd like to submit any changes you might want along with
> those.

I'd like to add that these two initial patches are now a prerequisite
for Hanjun's series, so it'd be good to have an idea of where we're
going on that front.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
