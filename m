From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Fri, 28 Sep 2018 19:09:02 +0800
Subject: [PATCH v2 04/11] arm64: dts: sc9836/sc9860: Update coresight
 bindings for hardware ports
In-Reply-To: <CAK8P3a2WWFp5W5-7o-X3joOpSGgnK=s_ZyGev7gsVV0SjN0p0A@mail.gmail.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-5-suzuki.poulose@arm.com>
 <ccc61e1b-768c-2a6d-3ff5-95b72bc58a6f@arm.com>
 <CAAfSe-swWPgCWN6cZbQxLL6fwaJ1qLXnC_X7A0zeYuHDaZ_A1Q@mail.gmail.com>
 <CAK8P3a2WWFp5W5-7o-X3joOpSGgnK=s_ZyGev7gsVV0SjN0p0A@mail.gmail.com>
Message-ID: <CAAfSe-sD-Yk2N-7aRuBW8UuX5=111Ofb5GLZRTHQKJ5n+Y=uog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 September 2018 at 18:45, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 27, 2018 at 11:19 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>>
>> Hi Suzuki,
>>
>> On 27 September 2018 at 16:51, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> > +To: Chunyan Zhang
>> >
>> > Chunyan Zhang,
>> >
>> > On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
>> >>
>> >> Switch to the new coresight bindings for hw ports
>> >>
>> >
>> > How can we push this patch ? Do you generally send the spreadtrum
>> > specific changes to ARM soc folks ? Or would you like me to post
>> > this directly to ARM soc folks ?
>>
>> Yeah, at present sprd dts files generally got merged through arm-soc
>> (I've added arm at kernel.org).
>
> Yes, that's fine. Generally, we prefer if you collect patches for your
> platform first, and then send them as a pull request or short set
> of patches. for inclusion, rather than picking them up from the list.
>

Ok, I will send you a patchset once merge window open.

Thanks,
Chunyan

> If this is the only DT patch for spreadtrum in 4.20, I can also just
> pick it up with your Ack.
>
>        Arnd
