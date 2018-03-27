From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 16:03:10 +0200
Subject: [PATCH v2 0/4] Introduce PMSAv8 memory protection unit
In-Reply-To: <2749c3e2-1046-a23f-b91c-f456f304d5c3@arm.com>
References: <1518790485-2321-1-git-send-email-vladimir.murzin@arm.com>
 <2415fbb7-a171-2917-35bc-4f2ee128f7c3@arm.com>
 <2749c3e2-1046-a23f-b91c-f456f304d5c3@arm.com>
Message-ID: <CAK8P3a0BGZqP2edQcd3xO7Dozg-=7qpP4qfXeGd1PWkvsLMUVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 11:06 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> On 08/03/18 13:36, Vladimir Murzin wrote:
>> On 16/02/18 14:14, Vladimir Murzin wrote:
>>> Hi,
>>>
>>> This series adds support for PMSAv8 MPU defined by ARMv8R/M
>>> architecture.
>>>
>>> Changelog:
>>>
>>>      v1 -> v2
>>>      - Included missed patch.
>>>      - Folded "ARM: NOMMU: Make _stext and _end meet PMSAv8 alignment
>>>        restrictions" into "ARM: NOMMU: Support PMSAv8 MPU" since it
>>>        allows us to refer PMSAv8_MINALIGN in linker scripts.
>>>      - Improved and tested XIP support
>>>
>>>     RFC -> v1
>>>      - Rebased on v4.16-rc1
>>>      - Added Tested-by for v7M bits from Andras
>>>
>>> Thanks!
>>
>> OK for patch tracker?
>
> The patches were on the list for a month and half without much attention
> except v7M folks (thanks them for testing!) and I'm afraid it would be even
> harder to make progress with them in nearby feature.
>
> I'm wondering if ARM SoC team can pick the patches?

This is really core code that should go through Russell's tree.

      Arnd
