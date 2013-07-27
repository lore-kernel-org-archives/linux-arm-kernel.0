From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Jul 2013 17:05:55 -0700
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130727000453.GC24642@n2100.arm.linux.org.uk>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
 <20130726215859.GA19469@glitch>
 <20130726231108.GA10812@obsidianresearch.com>
 <20130726234237.GB24642@n2100.arm.linux.org.uk>
 <CAOesGMiPHh1FcWM1Tfvq+e-9znQ6zRKGwmzJGe+jGj5GZsaGqA@mail.gmail.com>
 <20130727000453.GC24642@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMh01WMmhUyNa-usF8q-mYVp41RZRc=j1LPbv-hu0ftDyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 5:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 26, 2013 at 05:01:08PM -0700, Olof Johansson wrote:
>> On Fri, Jul 26, 2013 at 4:42 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Thank you for making me look at that file and see how people fail to read
>> > my comments about keeping stuff appropriately sorted.  Really makes me
>> > wonder why I bother.
>>
>> Grmbl. This one escaped me probably because the comment is at the top,
>> so I didn't see it when just reviewing the patch. I should obviously
>> have caught it anyway since the list was so obviously sorted before.
>> My bad. I'll send a patch in a bit.
>
> I've already a patch in my fixes.  It'll appear in -next probably after
> the weekend (as next doesn't update over weekends.)
>
> Note that the misordering is not due to these patches, but other previous
> patches.

Ok, sounds good.

And yeah, it's pretty obvious based on the order that it has crept in over time.


-Olof
