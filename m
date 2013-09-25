From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 25 Sep 2013 13:21:06 -0700
Subject: [PATCH 0/5] Allwinner SoCs High Speed Timer support
In-Reply-To: <CAOesGMhTZS1MdHW9cL4s_X8jUXHS3VkNZupCfX4ZGroL6k4gEw@mail.gmail.com>
 (Olof Johansson's message of "Wed, 25 Sep 2013 11:14:46 -0700")
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 <87zjr04vnh.fsf@linaro.org>
 <CAOesGMhTZS1MdHW9cL4s_X8jUXHS3VkNZupCfX4ZGroL6k4gEw@mail.gmail.com>
Message-ID: <87fvss7ivh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> On Wed, Sep 25, 2013 at 11:13 AM, Kevin Hilman <khilman@linaro.org> wrote:
>
>>> However, the A20 and A31 come with 4 of these high speed timers,
>>> while the A10s
>>> and A13 only have two, hence why we introduce two different compatibles.
>>
>> ...but the A10 has 2?
>>
>> -ECONFUSED
>
> A10s != A10. Yes, confusing. :)

Aaaaaah.  Silly me for thinking that the trailing 's' meant plural.

Thanks for clarifying.

Kevin
