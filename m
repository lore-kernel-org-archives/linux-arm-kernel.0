From: guenter@roeck-us.net (Guenter Roeck)
Date: Tue, 14 Oct 2014 06:30:29 -0700
Subject: ARMADA 370 - Distributed Switch Architecture (dsa) - device tree
In-Reply-To: <60c451c4cbeb4666fff3b45ffdcb780e@twien.net>
References: <f1e8d1ba750bfb63f84471d0ec7de988@twien.net>
 <20141013182517.GA18105@roeck-us.net>
 <60c451c4cbeb4666fff3b45ffdcb780e@twien.net>
Message-ID: <543D2575.6050209@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2014 11:05 PM, post at twien.net wrote:
> Hi Guenter,
> I'm doing this for my employer and have currently no plans for submitting this upstream. Not that I think we will not be willing to, but it's still very premature and I have so far not been able to test this. Am basically struggling to get 'dsa' up and working.

Hah, yes, that has its own challenges. Took me a while too.
I can send you a working platform file if you think it would help,
though that would be for x86, not for devicetree use.

Also, I could publish a branch with my 6352 driver on top of
the 3.14 kernel (which is where it is currently used) if it helps.

Guenter

> Best,
> Tormod
>
> On 2014-10-13 20:25, Guenter Roeck wrote:
>> On Mon, Oct 13, 2014 at 12:14:41PM +0200, post at twien.net wrote:
>>> Dear all,
>>> I have a custom board equipped with an ARMADA 370 SoC (88f6W11) and
>>> a Marvell switch chip (88e6352) (I have written a device driver for
>>> the latter).
>>
>> Hi Tormod,
>>
>> coincidentially, I have a DSA driver for 88e6352 almost ready for submitting it
>> upstream. What are your plans for your driver ? Do you plan to submit it
>> upstream ? Either case, it would be great if you could share a pointer to it
>> so we can make sure that it works for both our use cases.
>>
>> I have made my patch set available in the 'dsa' branch of
>> https://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.git
>> in case you are interested.
>>
>> Thanks,
>> Guenter
>
