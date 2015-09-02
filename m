From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 2 Sep 2015 12:00:52 +0200
Subject: [PATCH 02/14] arm64: Handle section maps for swapper/idmap
In-Reply-To: <55E6C4A2.7080307@arm.com>
References: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
 <1439465645-22584-3-git-send-email-suzuki.poulose@arm.com>
 <CAKv+Gu-0ut3o3iy322tbyqLAmR_gfzoE5272O3U3qSd5Zoh0Hw@mail.gmail.com>
 <55E6C4A2.7080307@arm.com>
Message-ID: <CAKv+Gu_VUSxTNb1muM8qykWjHQjcuys+_1Dfa37xRjGE5G+QGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 September 2015 at 11:42, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
> On 02/09/15 10:38, Ard Biesheuvel wrote:
>>
>> On 13 August 2015 at 13:33, Suzuki K. Poulose <suzuki.poulose@arm.com>
>> wrote:
>>>
>>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>>
>>> We use section maps with 4K page size to create the
>>> swapper/idmaps. So far we have used !64K or 4K checks
>>> to handle the case where we use the section maps. This
>>> patch adds a symbol to make it clear those cases.
>>>
>>
>> That sentence does not make sense.
>
>
> I agree. How about :
>
> "This patch adds a new symbol, 'ARM64_SWAPPER_USES_SECTION_MAPS', to
> handle cases where we use section maps, instead of using the page size
> symbols."
>

Yep, much better
