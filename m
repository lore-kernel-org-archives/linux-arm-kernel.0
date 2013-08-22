From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 11:10:59 -0700
Subject: [GIT PULL v2] pull request to 3.12 for hi3xxx
In-Reply-To: <CAN1soZz6WWDVwTE5eFOXuQHAPoOGajHaNhFzJBLZh5Gwj_u9ZQ@mail.gmail.com>
 (Haojian Zhuang's message of "Wed, 21 Aug 2013 16:25:37 +0800")
References: <CAN1soZz6WWDVwTE5eFOXuQHAPoOGajHaNhFzJBLZh5Gwj_u9ZQ@mail.gmail.com>
Message-ID: <87y57tr3yk.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> On Wed, Aug 21, 2013 at 5:52 AM, Kevin Hilman <khilman@linaro.org> wrote:
>> Hello Haojian,
>>
>> Haojian Zhuang <haojian.zhuang@gmail.com> writes:
>>
>>> Hi all,
>>>
>>> Please help to merge hi3xxx from pxa git tree.
>>>
>>
>> Thanks for sending the pull request to to arm at kernel.org, but please be
>> sure to *also* send it to the linux-arm-kernel mailing list.
>>
>> Thanks,
>>
>> Kevin
>>
>
> Hi Kevin,
>
> Now I update this pull request since I drop the support of Hi3716 DKB.
>

Thanks for the update.  However, now that I had a closer look at this
series, I don't think it's ready for merge.  In particular, I think
that the DT bindings and additions need a broader review from the DT
maintainers.  I pointed out a couple questions in a reply to one of the
specific patches: [PATCH v7 05/11] ARM: dts: enable hi4511 with device tree

I'm hoping the DT maintainers can step in here and help review your
changes and give guidance on any changes needed.

Kevin
