From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 13 Feb 2012 21:01:43 +0800
Subject: [PATCH 02/11] Revert "ARM: pxa: add dummy clock for sa1100-rtc"
In-Reply-To: <20120211194207.GV889@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
 <E1Rntz6-0002pN-UE@rmk-PC.arm.linux.org.uk>
 <4F36BC63.70403@cam.ac.uk>
 <20120211194207.GV889@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZxbju453j01g73E69UjzgY=9AKQ8_ct7oXaY1_+XE3=Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2012 at 3:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Feb 11, 2012 at 07:07:15PM +0000, Jonathan Cameron wrote:
>> On 01/19/2012 03:33 PM, Russell King - ARM Linux wrote:
>> > This reverts commit 7557c175f60d8d40baf16b22caf79beadef8f081.
>> >
>> > This revert is necessary to revert the broken "RTC: sa1100:
>> > support sa1100, pxa and mmp soc families" change.
>>
>> Taking out the lines concerning the dummy clk for pxa-gpio is
>> causing stargate2's smc91x driver to fail to find the part.
>>
>> So reverting the regression cause caused a different regression.
>>
>> Something 'unusual' occured with the commit you reference above.
>> The gpio line was added in 389eda15e0f41112d7c44213b3c4f8bd1c9398bc
>
> Sigh. ?I give up with this issue, people are obviously useless at
> properly separating their changes. ?Someone else can sort out this
> bloody mess.
>
Sure. I'll try to fix this issue in this week.
