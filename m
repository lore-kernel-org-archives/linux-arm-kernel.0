From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 9 Sep 2013 16:28:55 +0900
Subject: [PATCH 02/04] ARM: shmobile: r8a7791 SCIF support
In-Reply-To: <20130909070941.GA27194@verge.net.au>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034608.12546.79411.sendpatchset@w520>
 <CACRpkdY=j_XRPd9-CV-wj9ajSDZMA1H=k8uK1T2040rmfY=R_A@mail.gmail.com>
 <20130909001524.GD21921@verge.net.au>
 <CACRpkdYwA0ADogtB8RfkZt2bmdbr-PmjvV1=xBKam15DXi9F8A@mail.gmail.com>
 <20130909070941.GA27194@verge.net.au>
Message-ID: <CANqRtoRksgU7B-80GnfFRymgke13=Er4SpHV-ehGJST2vZAD5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Sep 9, 2013 at 4:09 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Sep 09, 2013 at 08:54:59AM +0200, Linus Walleij wrote:
>> On Mon, Sep 9, 2013 at 2:15 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Fri, Sep 06, 2013 at 06:27:22PM +0200, Linus Walleij wrote:
>>
>> >> Again this looks like it is piling up more legacy clk
>> >> code instead of moving to the new frameworks.
>> >>
>> >> Please include Mike Turquette on future postings of the
>> >> clk code, he's definately our best clock code reviewer.
>> >
>> > Perhaps I was a bit hasty, but I have already queued up these changes.
>> > And moreover I believe they are useful in their current form for
>> > back-porting to LTSI-3.4, which I have also already done.
>>
>> That sounds like you're a bit too trigger-happy ;-)
>
> Perhaps.
>
>> > So on those two counts my preference would be for any enhancements
>> > to be done as incremental patches on top of this series.
>>
>> Hm hm. I am worried that it is taken as an OK to proceed
>> extending old cruft for new SoCs rather than moving to new
>> frameworks. I would agree if such migration patches were
>> floating the lists but I am not aware of any patches starting
>> to create drivers/clk/sh*, are you?
>
> I am not aware of such patches.

Several people have spent time on common clocks, the most recent
efforts have been for the EMEV2 SoC. Nothing is upstream yet though,
but if all goes according to our plan then we will start seeing common
clock patches in october-november some time.

> I will defer this to Magnus who is both the author of this series
> and I believe the person who knows the most about the plans for
> drivers/clk/sh*.

I'm actually only the author of some portions of this series, but sure. =)

If there is anything special you'd like to know about common clocks on
mach-shmobile then please let me know.

Cheers,

/ magnus
