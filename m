From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Thu, 9 Jan 2014 14:00:58 +0200
Subject: [PATCH 2/5] ARM: kprobes-test: use <asm/opcodes.h> for
 instruction accesses
In-Reply-To: <1389265491.4041.6.camel@linaro1.home>
References: <1387815579-15677-1-git-send-email-taras.kondratiuk@linaro.org>
 <1387815579-15677-3-git-send-email-taras.kondratiuk@linaro.org>
 <1388764386.3430.10.camel@linaro1.home>
 <CAArO44ump6fid28qDGYK3=vMNLpgicMjYNO1hOdyU7D-Lkd3bQ@mail.gmail.com>
 <1389265491.4041.6.camel@linaro1.home>
Message-ID: <CAArO44vRhQrxD25q=+SsgnRpd3UV0T=KZV_yh=uTEu0-PinMFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks.
I'll prepare a pull request.

On 9 January 2014 13:04, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> On Thu, 2014-01-09 at 12:54 +0200, Taras Kondratiuk wrote:
>> On 3 January 2014 17:53, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
>> > On Mon, 2013-12-23 at 18:19 +0200, Taras Kondratiuk wrote:
>> >> From: Ben Dooks <ben.dooks@codethink.co.uk>
>> >>
>> >> Ensure we read instructions in the correct endian-ness by using
>> >> the <asm/opcodes.h> helper to transform them as necessary.
>> >>
>> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> >> [taras.kondratiuk at linaro.org: fix next_instruction() function]
>> >> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
>> >> ---
>> >
>> > Apart from the spurious line removal (see below) then:
>> >
>> > Acked-by: Jon Medhurst <tixy@linaro.org>
>> >
>> > and you can include an ACK for the other patches in this series too.
>> >
>> > Thanks.
>>
>> >> @@ -1593,7 +1594,6 @@ static int run_test_cases(void (*tests)(void), const union decode_item *table)
>> >>       return 0;
>> >>  }
>> >>
>> >> -
>> >
>> > I know the above blank line isn't needed but I believe the convention is
>> > to avoid doing unrelated white-space clean-ups in patches.
>>
>> Right, I will remove it.
>> Should this series go through Russell's patch tracking system or it
>> can be pulled
>> to some tree?
>
> I would assume as a pull request sent to Russell using the email alias
> he uses for these things: linux+pull at arm.linux.org.uk I'm sure he's
> shout up if I'm wrong...
>
> --
> Tixy
>



-- 
Regards,
Taras Kondratiuk
