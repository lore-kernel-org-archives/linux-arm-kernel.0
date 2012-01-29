From: rob.clark@linaro.org (Rob Clark)
Date: Sun, 29 Jan 2012 12:09:03 -0600
Subject: [PATCHv19 00/15] Contiguous Memory Allocator
In-Reply-To: <20120127162624.40cba14e.akpm@linux-foundation.org>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <201201261531.40551.arnd@arndb.de>
 <20120127162624.40cba14e.akpm@linux-foundation.org>
Message-ID: <CAN_cFWMPNRx75GC0d0Z5CZC0dPH=wv1YVuA+7j4pfFh9ww9bgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 6:26 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 26 Jan 2012 15:31:40 +0000
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Thursday 26 January 2012, Marek Szyprowski wrote:
>> > Welcome everyone!
>> >
>> > Yes, that's true. This is yet another release of the Contiguous Memory
>> > Allocator patches. This version mainly includes code cleanups requested
>> > by Mel Gorman and a few minor bug fixes.
>>
>> Hi Marek,
>>
>> Thanks for keeping up this work! I really hope it works out for the
>> next merge window.
>
> Someone please tell me when it's time to start paying attention
> again ;)
>
> These patches don't seem to have as many acked-bys and reviewed-bys as
> I'd expect. ?Given the scope and duration of this, it would be useful
> to gather these up. ?But please ensure they are real ones - people
> sometimes like to ack things without showing much sign of having
> actually read them.
>
> Also there is the supreme tag: "Tested-by:.". ?Ohad (at least) has been
> testing the code. ?Let's mention that.
>

fyi Marek, I've been testing CMA as well, both in context of Ohad's
rpmsg driver and my omapdrm driver (and combination of the two)..  so
you can add:

Tested-by: Rob Clark <rob.clark@linaro.org>

And there are some others from linaro that have written a test driver,
and various stress test scripts using the test driver.  I guess that
could also count for some additional Tested-by's.

BR,
-R

> The patches do seem to have been going round in ever-decreasing circles
> lately and I think we have decided to merge them (yes?) so we may as well
> get on and do that and sort out remaining issues in-tree.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
