From: p.osciak@samsung.com (Pawel Osciak)
Date: Tue, 18 May 2010 09:58:43 +0200
Subject: Samsung SoCs framebuffer re-work
In-Reply-To: <20100518071608.GQ27571@trinity.fluff.org>
References: <AANLkTinThrLrsxBYHs-1xPqIaRiK1HH-YZkcloKHnzkx@mail.gmail.com>
	<20100518025058.GL27571@trinity.fluff.org>
	<AANLkTimfbcYLyiuErIMcDqfAzz2L76J3j2IxlWS0b333@mail.gmail.com>
	<20100518055319.GP27571@trinity.fluff.org>
	<000101caf656$ff21b560$fd652020$%osciak@samsung.com>
	<20100518071608.GQ27571@trinity.fluff.org>
Message-ID: <000c01caf65f$efda0810$cf8e1830$%osciak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>Ben Dooks <mailto:ben-linux@fluff.org> wrote:
>On Tue, May 18, 2010 at 08:54:44AM +0200, Pawel Osciak wrote:
>>
>> > Ben Dooks wrote:
>> >On Tue, May 18, 2010 at 12:09:25PM +0900, Kyungmin Park wrote:
>> >> On Tue, May 18, 2010 at 11:50 AM, Ben Dooks <ben-linux@fluff.org> wrote:
>> >> > On Tue, May 18, 2010 at 08:59:29AM +0900, Kyungmin Park wrote:
>> >> >
>> >> >> As you can see the s5pc110 (aka s5pv210) spec, It has more features
>> >> >> and interconnection between FIMC and FIMD.
>> >> >> So current fb driver can't handle these features well. So LSI make a
>> >> >> own fb drivers and use it. You can see the code at their git repo.
>> >> >>
>> >> >> Now we are re-implement or change it for s5pc110 and for future
>usages.
>> >> >> How do you think?
>> >> >
>> >> > I've already got updates for s3c-fb to work on 2416,2443 and the
>> >c110/v210
>> >> > systems. I am talking with the relevant people at System.LSI to get
>our
>> >> > drivers closers together, possibly we can get this done for the
>current
>> >> > merge window.
>> >>
>> >> You mean you want to use the current fb drivers for s5pc110 also?
>> >> Then how to do implement features mentioned by Kukjin?
>> >
>> >Well, apart from the fact that quite a lot of them are actually features
>> >that are in all versions of this block, we intend to create some patches
>> >and send them to the relevant lists...
>>
>> I posted patches for s3c-fb back in September (Sep. 3rd and 11th), which
>> added some of the abovementioned features, including VSYNC, double-
>buffering
>> support, color-keying, alpha blending and more. Are there any plans for
>> those?
>
>Either not seen them or missed them completely.
>
>Do you have URLs to have a look at them?

[PATCH v2 0/3] v2: s3c-fb panning and vsync support:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/000370.html

[PATCH 0/7] [ARM] s3c-fb: Various s3c-fb updates:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/000600.html


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
