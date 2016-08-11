From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 10 Aug 2016 19:46:53 -0500
Subject: "Failed to create /dev/root: -14" after commit e6978e4bf1 ("ARM:
 save and reset the address limit when entering an exception")
In-Reply-To: <20160810234325.GR1041@n2100.armlinux.org.uk>
References: <57A15C41.6000804@roeck-us.net>
 <20160803083822.GI1041@n2100.armlinux.org.uk>
 <57A20896.30300@roeck-us.net> <20160804100748.GP1041@n2100.armlinux.org.uk>
 <87eg5y3rsk.fsf@free-electrons.com>
 <CAOi56cUMzOVzcOOwW433YH1hsyiSTHofgQP5a1ghaTu94fL01w@mail.gmail.com>
 <20160810234325.GR1041@n2100.armlinux.org.uk>
Message-ID: <CAOi56cWd5b4YaBEzRnUUrGV+FCw0QWv+NtdBjkt0jot-Mf7S1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 6:43 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Aug 10, 2016 at 06:34:22PM -0500, Kevin Hilman wrote:
>> I also tested this fixes the boot issue on Armada XP.
>>
>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>
> It should be in the current linux-next.  I'll send them on in the
> usual way over the weekend for -rc2, with your ack for this one.

Also, I noticed your for-next branch is going through boot testing
right now in my kernelci lab, and I see it passed on the Armada XP, so
that's more evidence for the fix.

Thanks,

Kevin
