From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 1 Oct 2018 01:55:19 +0100
Subject: [PATCH] arm64: dts: allwinner: a64: Re-add "syscon" compatible
In-Reply-To: <20180926095202.tdibor3x7fsn6afz@flea>
References: <20180917152857.162662-1-andre.przywara@arm.com>
 <CAGb2v643=V_3DbLeEyXEavSQJsW2KdknpZZLfw4QwCjhfdmVsA@mail.gmail.com>
 <20180921153522.0413c280@donnerap.Emea.Arm.com>
 <20180921151625.wkaypyueyi2pguur@flea>
 <20180924112230.73e3009b@donnerap.Emea.Arm.com>
 <20180926095202.tdibor3x7fsn6afz@flea>
Message-ID: <22014c5e-fee0-d4c6-bc6c-cd30c8545292@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/26/18 10:52 AM, Maxime Ripard wrote:

Hi Maxime,

> On Mon, Sep 24, 2018 at 11:22:30AM +0100, Andre Przywara wrote:
>>> The fundamental difference is that we're mostly just a bunch of spare
>>> time programmers working on this platform, with a partial
>>> documentation for the controllers, at best.
>>>
>>> You forced me to ask these developpers to work on their weekends and
>>> evenings on some crazy corner cases to maintain the backward
>>> compatibility. And honestly, both from a technical and human
>>> standpoint, I definitely understand if some of them are just leaving
>>> and don't want to work on it anymore. I would probably do the same in
>>> their position.
>>>
>>> And having to ask that for companies like ARM or SUSE just makes it
>>> more frustrating to be honest. So there's simply no way you have
>>> forward compatibility while I'm there. Or you manage to convince all
>>> the ARM maintainers and enforce that compatibility for all the
>>> platforms.
>>
>> I understand that from your point of view there is no way of investing
>> huge efforts in staying forward compatible, but I am not asking for
>> that (and by no way forcing this!). Instead this suggestion is a small
>> tweak to achieve this.
> 
> We're trying to remain compatible but if there's any technical reason,
> then we won't be. I don't want anyone to assume we will, and to rely
> on the fact that we are actually guaranteeing this.

I understand that this is not the forum to discuss this, so have to
accept your position here. But I don't think this means we can't try to
solve those issues on case-by-case base? Just because we don't guarantee
this doesn't mean we shouldn't even try.

>> So I am sorry if those things frustrate you (which I can understand
>> very well), but I believe fixing the DT in a proper way is
>> much more user friendly in the long term (actually this issue was
>> brought forward by a user[1]).
> 
> Given the current state of the industry, I don't really see how the DT
> can allow you to do what you are trying to achieve.

I am not sure I do understand what you mean with "industry"? If you are
thinking about the SoC vendor or board vendors to push this endeavor and
create stable bindings and DTs from the beginning: I see that this won't
work with the prevalent attitude across many vendors today.

But in our case we (as the community) drive the DTs and the bindings
anyway, and we decided to mostly ignore Allwinner's DT effort - for good
reasons. So we can - given consensus on the goals and approach - make
this possible and don't need to rely on any company or "industry".

I find it a bit pity that we are stuck with this embedded approach,
where each board(!) vendor AND community members produce gazillions of
questionable images with all kind of distribution flavors.
At the moment (mainline U-Boot with EFI support and shipping with decent
DTs) we are very close to let people install distros with off-the-shelf
installers. I think this is a goal worthwhile fighting for.

Cheers,
Andre.
