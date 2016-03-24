From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 24 Mar 2016 11:10:11 -0000
Subject: Who is going to merge it [Was: Re: [PATCH v14 0/17] Add Analogix
 Core Display Port Driver]
In-Reply-To: <CAPM=9tz9_rbGJFuv-+YN=Sicfng++tHTDLrOX5Ohtwft+VnwtA@mail.gmail.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>	<1919945.Y1tg0YzXlm@diego>	<56F1CAEB.3080701@samsung.com>	<8949624.HmxDpZAlt2@diego>	<56F1D0AD.8030905@samsung.com>	<20160322233906.GP19428@n2100.arm.linux.org.uk>	<56F1DB27.4040001@samsung.com>	<20160323000835.GQ19428@n2100.arm.linux.org.uk>
 <CAPM=9tz9_rbGJFuv-+YN=Sicfng++tHTDLrOX5Ohtwft+VnwtA@mail.gmail.com>
Message-ID: <5A08F152.40705@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/22/2016 08:41 PM, Dave Airlie wrote:
>>> So although it's small framework or just subdirectory, we would need
>>> someone who can manage the framework to avoid further confusion if
>>> necessary.
>> So maybe it just doesn't need a maintainer, and maybe those the owner
>> of the bridge driver should be responsible for choosing the tree which
>> it's merged through along with updates.  That's how dw-hdmi has been
>> managed on the whole.
>>
>> It also means that the bridge driver maintainer is able to test changes
>> to the bridge driver, rather than having some over-arching bridge
>> subdirectory maintainer who doesn't have a clue whether the changes
>> work on the hardware.
>>
>> IMHO, having bridge driver authors/maintainers look after their own
>> code has many advantages.
> The author just send me a pull request with acks from a git tree
> that hopefully both people agreed and tested from. No need to
> send this via another maintainer layer.
>
> Dave.
>

Wow, thanks all ! such cool news  :-D  I'll prepare my pull request soon


- Yakir
