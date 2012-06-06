From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 6 Jun 2012 13:25:54 +0800
Subject: [PATCH v2 8/9] ARM: dts: refresh dts file for arch mmp
In-Reply-To: <4FCEE91F.1030308@firmworks.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
 <1336134626-12262-9-git-send-email-haojian.zhuang@gmail.com>
 <87d35ezkm1.fsf@laptop.org> <201206060128.28167.arnd@arndb.de>
 <4FCEB694.8080904@firmworks.com>
 <CAN1soZykbTFGk=qAmzDe2qyQVVYBJpxcPYh6OzWyPxiBacJ-mg@mail.gmail.com>
 <4FCEE91F.1030308@firmworks.com>
Message-ID: <CAN1soZx5BiY4kgt1EzbyFqRQOAYxkX9p2sNbrxZ-D=oocZuuRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 6, 2012 at 1:22 PM, Mitch Bradley <wmb@firmworks.com> wrote:
> On 6/5/2012 4:35 PM, Haojian Zhuang wrote:
>>
>> On Wed, Jun 6, 2012 at 9:47 AM, Mitch Bradley<wmb@firmworks.com> ?wrote:
>>>
>>> On 6/5/2012 3:28 PM, Arnd Bergmann wrote:
>>>>
>>>>
>>>> On Tuesday 05 June 2012, Chris Ball wrote:
>>>>>
>>>>>
>>>>> Hi Haojian,
>>>>>
>>>>> On Fri, May 04 2012, Haojian Zhuang wrote:
>>>>>>
>>>>>>
>>>>>> Append mmp2 and pxa910 dts files. Update PXA168 dts files for irq,
>>>>>> timer, gpio components.
>>>>>
>>>>>
>>>>>
>>>>> The patch I'm replying to introduced a device tree for MMP2/Brownstone
>>>>> in 3.5-rc1. ?We're looking at adopting the MMP2 device tree for the
>>>>> OLPC
>>>>> XO-1.75 board, and Mitch Bradley has some corrections to the device
>>>>> tree
>>>>> format that we'd like to make, appended below.
>>>>>
>>>>> You can see all of the files Mitch mentions at:
>>>>> http://dev.laptop.org/~wmb/mmp2-devicetree/
>>>>>
>>>>> Here's my proposal for what to do next:
>>>>> ?* First, you choose one of the two forms that Mitch links to.
>>>>> ? ?(Either "mmp2.dtsi" or "mmp2-flat.dtsi"; we have a weak preference
>>>>> ? ?for mmp2-flat.dtsi.)
>>>>
>>>>
>>>>
>>>> My preference would be towards mmp2.dtsi. I've recommended doing it
>>>> that way to other people, too.
>>>
>>>
>>> In most cases, I have found that exposing the full hierarchy is
>>> preferable.
>>> ?For this specific SoC, which I have been working with for quite awhile
>>> now,
>>> I haven't found any instance where exposing the AXI/APB levels buys you
>>> anything. ?The hierarchy just adds clutter.
>>>
>>> That said, I don't feel strongly about it.
>>>
>> mmp2-brownstone.dts is too complex since both apb& ?axi are imported.
>>
>> Could we only use flat structure in mmp2-brownstone.dts?
>
>
> See http://dev.laptop.org/~wmb/mmp2-devicetree/mmp2-brownstone-flat.dts
> <http://dev.laptop.org/%7Ewmb/mmp2-devicetree/mmp2-brownstone-flat.dts>
>

My meaning is mmp2-brownstone-flat.dts + mmp2.dtsi. Is it acceptable?
