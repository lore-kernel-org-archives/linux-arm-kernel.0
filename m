From: alchark@gmail.com (Alexey Charkov)
Date: Sat, 15 Jan 2011 04:13:48 +0300
Subject: [PATCH 1/6 v12] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20110115005818.GV15996@n2100.arm.linux.org.uk>
References: <4D1011CF.9080800@bluewatersys.com>
	<AANLkTi=7O-HwQRcybnLSt+r+A64g=D7rZY7NbdEMFys3@mail.gmail.com>
	<4D110269.9030805@bluewatersys.com>
	<20101222211815.GA31054@alchark-u3s>
	<4D12730B.2030909@bluewatersys.com>
	<20101222222501.GA32693@alchark-u3s>
	<4D1282DA.4020804@bluewatersys.com>
	<20101222233821.GA20893@alchark-u3s>
	<AANLkTik1tcL_ABdnq5r=MCxmLJtdP0nhOzA8irP1n0CC@mail.gmail.com>
	<AANLkTinb3A5CJ6r4Y0D0kMwJn8ZEyf_0mb4uW99mmUZ9@mail.gmail.com>
	<20110115005818.GV15996@n2100.arm.linux.org.uk>
Message-ID: <AANLkTintT+dnpKvosuzS6aMV0dw0+2rBw2=S53-D-atp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<previous response went off-list by mistake, sorry for that>

2011/1/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Jan 15, 2011 at 03:53:56AM +0300, Alexey Charkov wrote:
>> 2010/12/28 Alexey Charkov <alchark@gmail.com>:
>> > 2010/12/23 Alexey Charkov <alchark@gmail.com>:
>> >> This adds support for the family of Systems-on-Chip produced initially
>> >> by VIA and now its subsidiary WonderMedia that have recently become
>> >> widespread in lower-end Chinese ARM-based tablets and netbooks.
>> >>
>> >> Support is included for both VT8500 and WM8505, selectable by a
>> >> configuration switch at kernel build time.
>> >>
>> >> Included are basic machine initialization files, register and
>> >> interrupt definitions, support for the on-chip interrupt controller,
>> >> high-precision OS timer, GPIO lines, necessary macros for early debug,
>> >> pulse-width-modulated outputs control, as well as platform device
>> >> configurations for the specific drivers implemented elsewhere.
>> >>
>> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> >
>> > Russell, will you take this for .38? Please note that the last
>> > revision of this patch was also submitted to the ARM Linux patch
>> > tracking system:
>> >
>> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6597/1
>> >
>> > Best regards,
>> > Alexey
>> >
>>
>> Russell, I realize that there are quite a lot of other things to worry
>> about currently in the ARM Linux world, but could you please still
>> consider merging this patch before .38 window closes?
>
> It got lost in the patch system in the middle of the SPEAR deluge -
> and after that deluge I did say on list that it would result in things
> being missed. ?I've basically been ignoring everything in there since
> beyond the top few newest entries.
>
> In any case, I believe it's too late in this merge window with only
> four days left to start merging large amounts of code. ?I'd get
> moaned at by Linus. ?Sorry.
>

Ok, life is life. Could you then please take these to your tree for .39?

Best regards,
Alexey
