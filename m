From: radoslav.kolev@embedlynx.com (Radoslav Kolev)
Date: Wed, 4 May 2016 15:30:39 +0300
Subject: [PATCH 1/1] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <CAGb2v66r9m7qVW6BszeT2wqs0KyEr4x5ivTJYqu2Fes=R9-Ltw@mail.gmail.com>
References: <1461827998-12192-1-git-send-email-oliver@schinagl.nl>
 <CAGb2v66E2TuN3+tYaAbniV3q67waDZOfqKAW14VJz6xZFomZ=Q@mail.gmail.com>
 <57285162.2000704@schinagl.nl>
 <CAGb2v66r9m7qVW6BszeT2wqs0KyEr4x5ivTJYqu2Fes=R9-Ltw@mail.gmail.com>
Message-ID: <CANCTEQgjiuQXcaw=3Dr5kUsTPc3nsDQf2odwzs4nHvrkREAqrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-05-03 10:25 GMT+03:00 Chen-Yu Tsai <wens@csie.org>:
> On Tue, May 3, 2016 at 3:21 PM, Olliver Schinagl <oliver@schinagl.nl> wrote:
>>>> +       bus-width = <4>;
>>>
>>> Only 4 bits? We normally see eMMC with 8 bits. 4 bits are some kind of
>>> embedded SD card.
>>
>> On A20 as well? Our investigations so far have concluded that the A10 and
>> A20 have those pins not mapped out to pads. The IP does support it however
>> we assume.
>
> You're right. My bad. First time A10/A20 sees eMMC support.

I can't say anything about A10/A20, but I have a board with A13 and
the same eMMC chip and it works fine in 8 bit mode.

Regards,
Radoslav
