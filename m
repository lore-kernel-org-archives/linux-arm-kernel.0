From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 09 Jul 2015 09:42:42 +0100
Subject: [PATCH 0/3] arm/arm64: vexpress: DT updates for v4.2
In-Reply-To: <CAMAWPa88wR+GcbdN1cHbF4Om0M8gEyBFi57mhORsSwDn7ab5OA@mail.gmail.com>
References: <1435754163-17929-1-git-send-email-sudeep.holla@arm.com>	<5596BCC3.9070903@arm.com>	<7hio9ue6ey.fsf@deeprootsystems.com>
 <CAMAWPa88wR+GcbdN1cHbF4Om0M8gEyBFi57mhORsSwDn7ab5OA@mail.gmail.com>
Message-ID: <559E3402.3020909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/07/15 22:46, Kevin Hilman wrote:
> On Wed, Jul 8, 2015 at 3:33 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> Sudeep Holla <sudeep.holla@arm.com> writes:
>>
>>> Hi Kevin,
>>>
>>> On 01/07/15 13:36, Sudeep Holla wrote:
>>>> Hi ARM-SoC guys,
>>>>
>>>> Here are couple of fixes for adding missing nodes(CCI and A7 PMUs) in
>>>> TC2 device tree. The third patch is addition of support for FPGA based
>>>> dual core A53 SMM  platform. All the patches are posted on the list
>>>> already, just putting them together. Let me know if you prefer a pull
>>>> request.
>>>>
>>>
>>> I just realized that I copied this series to your Linaro email instead
>>> of kernel.org. Sorry for that, do you want me to repost ?
>>
>> Not necessary.
>>
>> This just came too late for the v4.2 cycle.  I think the first two
>> patches we can take as fixes for v4.2, but the 3rd one will likely need
>> to wait for v4.3.

Agreed, will try my best not to repeat that again.

>
> Having a closer look, I just picked up all 3 for v4.2-rc.
>

Thanks.

Regards,
Sudeep
