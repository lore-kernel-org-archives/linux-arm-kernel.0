From: olof@lixom.net (Olof Johansson)
Date: Tue, 26 Aug 2014 21:13:56 -0700
Subject: [PATCH v2 0/5] ARM: shmobile: correct memory maps
In-Reply-To: <20140827040349.GA9830@verge.net.au>
References: <1409099726-21814-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTSxB3GQoYg6ecpKQ4N7JO2ahotjaAL3oEebE1h3PGtZg@mail.gmail.com>
 <CAOesGMiZPNkpoe1UJ0VG0yL1qHq-q7OOQUrJSdw_Z0sVFgDcwA@mail.gmail.com>
 <20140827040349.GA9830@verge.net.au>
Message-ID: <CAOesGMhV8Z1T67rwpSN4HVEFixSCApt4p0puRP36AH2MJyviZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 9:03 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Aug 26, 2014 at 07:27:53PM -0700, Olof Johansson wrote:
>> On Tue, Aug 26, 2014 at 6:45 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> > Hi Simon,
>> >
>> > On Wed, Aug 27, 2014 at 9:35 AM, Simon Horman
>> > <horms+renesas@verge.net.au> wrote:
>> >> This short series builds on a previous posting
>> >> of a patch to correct the value of the second memory region
>> >> of the lager. It does that and also corrects the syntax
>> >> used for the lager and other shmobile boards.
>> >>
>> >> Simon Horman (5):
>> >>   ARM: shmobile: lager: correct memory map value and syntax
>> >>   ARM: shmobile: henninger: correct memory map syntax
>> >>   ARM: shmobile: koelsch: correct memory map syntax
>> >>   ARM: shmobile: ape6evm-reference: correct memory map syntax
>> >>   ARM: shmobile: ape6evm: correct memory map syntax
>> >
>> > Thanks for improving the current state. The patches look fine to me.
>> >
>> > Acked-by: Magnus Damm <damm+renesas@opensource.se>
>>
>> Yep, agreed.
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>
> Thanks, I have queued these up as fixes for v3.17.
> I'll send you a pull-request in the not to distant future.

This is 3.18 cleanup material as far as I am concerned, so please send
it as such. :)


-Olof
