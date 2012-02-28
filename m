From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 Feb 2012 09:56:38 +0800
Subject: [PATCH 02/11] Revert "ARM: pxa: add dummy clock for sa1100-rtc"
In-Reply-To: <1330367087.26671.YahooMailClassic@web29007.mail.ird.yahoo.com>
References: <CAN1soZxbju453j01g73E69UjzgY=9AKQ8_ct7oXaY1_+XE3=Cw@mail.gmail.com>
 <1330367087.26671.YahooMailClassic@web29007.mail.ird.yahoo.com>
Message-ID: <CAN1soZzZsiNjGeNGz7JYZe5v3rQAY9N+XKmniPMN78SqMH0bhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 2:24 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
>> >> > This reverts commit
>> 7557c175f60d8d40baf16b22caf79beadef8f081.
>> >> >
>> >> > This revert is necessary to revert the broken
>> "RTC: sa1100:
>> >> > support sa1100, pxa and mmp soc families"
>> change.
>> >>
>> >> Taking out the lines concerning the dummy clk for
>> pxa-gpio is
>> >> causing stargate2's smc91x driver to fail to find
>> the part.
>> >>
>> >> So reverting the regression cause caused a
>> different regression.
>> >>
>> >> Something 'unusual' occured with the commit you
>> reference above.
>> >> The gpio line was added in
>> 389eda15e0f41112d7c44213b3c4f8bd1c9398bc
>> >
>> > Sigh. ?I give up with this issue, people are obviously
>> useless at
>> > properly separating their changes. ?Someone else can
>> sort out this
>> > bloody mess.
>> >
>> Sure. I'll try to fix this issue in this week.
>
> Removing the pxa-gpio dummy clk also broke the hx4700.

Thanks. I'll append it for pxa27x again.
