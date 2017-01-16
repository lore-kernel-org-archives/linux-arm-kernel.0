From: guohanjun@huawei.com (Hanjun Guo)
Date: Mon, 16 Jan 2017 22:41:26 +0800
Subject: [PATCH V9 0/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <8587b5ab-59b1-feb7-09d9-7ade6d433a4c@arm.com>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <16e3b40407e8072dd5b15bf7e65afb18@codeaurora.org>
 <CAJZ5v0h_v-iER5Fffdoczj4CAhetGYqOfJOhdO561_kNCnsEFg@mail.gmail.com>
 <266105963441d1cdddeaf40c4b78c239@codeaurora.org>
 <8587b5ab-59b1-feb7-09d9-7ade6d433a4c@arm.com>
Message-ID: <587CDB96.9000906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/16 22:14, Marc Zyngier wrote:
> On 16/01/17 14:07, Agustin Vega-Frias wrote:
>> Hi Rafael,
>>
>> On 2017-01-03 16:56, Rafael J. Wysocki wrote:
>>> On Tue, Jan 3, 2017 at 4:19 PM, Agustin Vega-Frias
>>> <agustinv@codeaurora.org> wrote:
>>>> Hi,
>>>>
>>>> Is there any more feedback on this beyond Lorenzo's suggestion to drop
>>>> the conditional check on the first patch?
>>>> How can we move forward on this series?
>>> Essentially, I need to convince myself that patches [1-2/3] are fine
>>> which hasn't happened yet.
>> Pinging again. Do you have any questions that might help with your
>> review? I have some minor changes I have to make to the driver itself
>> (patch 3) and I'd like to submit any changes you might want along with
>> those.
> I'd like to add that these two initial patches are now a prerequisite
> for Hanjun's series, so it'd be good to have an idea of where we're
> going on that front.

Is it helpful to test patch [1-2/3] on x86 machines (with different firmware) and
an IA64 machine (surely a different version of firmware :) ) with Lorenzo's suggestion
of removing  #ifdef CONFIG_ACPI_GENERIC_GSI for is_gsi()? If yes, I can do that as
I have such machines.

Thanks
Hanjun
