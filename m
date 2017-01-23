From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 23 Jan 2017 21:29:15 +0530
Subject: [PATCH RESEND 2/2] ARM: da850: add the nand dev_id to the clock
 lookup table
In-Reply-To: <CAMpxmJUcPQJw3YKEtmnqMnW1OqEH1mz3hosYJc2arK65Qwkz+Q@mail.gmail.com>
References: <1484301626-30345-1-git-send-email-bgolaszewski@baylibre.com>
 <1484301626-30345-3-git-send-email-bgolaszewski@baylibre.com>
 <0650f8ff-07f7-db06-ca3c-84eed7edb24e@ti.com>
 <8052f538-8573-c362-129c-a2ca6a64850e@ti.com>
 <CAMpxmJUcPQJw3YKEtmnqMnW1OqEH1mz3hosYJc2arK65Qwkz+Q@mail.gmail.com>
Message-ID: <ca65a02c-a067-9a4a-af7d-98bace48c5fd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 January 2017 09:02 PM, Bartosz Golaszewski wrote:
> 2017-01-23 16:17 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>> On Friday 20 January 2017 07:16 PM, Sekhar Nori wrote:
>>> On Friday 13 January 2017 03:30 PM, Bartosz Golaszewski wrote:
>>>> The aemif driver can now access struct of_dev_auxdata (using platform
>>>> data).
>>>>
>>>> Add the device id to the clock lookup table for the nand clock and
>>>> create a separate lookup table for aemif subnodes.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Applied to v4.11/soc
>>
>> I forgot that this has a build dependency with 1/2. Instead of creating
>> a dependency with Greg's tree, I think I will send it for v4.12. This is
>> a clean-up and does not add a new feature from a user's perspective so I
>> hope thats okay.
>>
>> Thanks,
>> Sekhar
> 
> Hi Sekhar,
> 
> Greg picked up both patches - 1/2 is already in char-misc-next[1].

Alright. I did not notice any merge conflicts between this and what I
plan to queue so I guess we are okay.

Thanks
Sekhar
