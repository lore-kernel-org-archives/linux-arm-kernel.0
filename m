From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Thu, 15 May 2014 12:10:29 -0300
Subject: [linux-sunxi] [PATCH 0/6] sunxi: clk: Various cleanup and rework
In-Reply-To: <20140513011232.5943.64136@quantum>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
 <536E6047.8010004@elopez.com.ar> <20140513011232.5943.64136@quantum>
Message-ID: <5374D8E5.8070300@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 12/05/14 22:12, Mike Turquette escribi?:
> Quoting Emilio L?pez (2014-05-10 10:22:15)
>> Hi Maxime,
>>
>> El 10/05/14 00:33, Maxime Ripard escribi?:
>>> Hi everyone,
>>>
>>> This patchset fixes a few things that have been pending for quite a
>>> while in the clock driver.
>>>
>>> First, it removes the clk_put calls in the clock protection
>>> part. Since it's not really something that should be done, I guess
>>> this patch is not very controversial.
>>>
>>> Then, it starts splitting the huge clock driver file into separate,
>>> smaller drivers when it makes sense.
>>>
>>> Finally, it reworks the clock protection mechanism to handle
>>> differences between SoC in a better way. This has been pretty
>>> controversial because the first approach has been to move this to the
>>> machine code. This is another attempt that leaves all the
>>> modifications in the driver itself.
>>>
>>> Thanks,
>>> Maxime
>>
>> Overall the series looks good to me, other than the comment about clkdev
>> on patches 2 and 3.
>>
>> @Mike, do you want me to take them in a pull as usual after you have a
>> look? Please let me know as we still haven't clarified the situation
>> with the two patches Hans sent.
>
> A pull request would be great. Feel free to add my Acked-by to all of
> the patches here (#1 already has it) since I looked at all of them and
> the changes seem good.

Ok, I've taken them in sunxi-clk-for-mike with Mike's ack. I'll be 
sending the pull request soon.

Cheers,

Emilio
