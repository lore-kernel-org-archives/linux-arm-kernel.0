From: dhillf@gmail.com (Hillf Danton)
Date: Mon, 6 Feb 2012 20:51:54 +0800
Subject: [PATCH 12/15] drivers: add Contiguous Memory Allocator
In-Reply-To: <op.v87mpive3l0zgt@mpn-glaptop>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
 <1328271538-14502-13-git-send-email-m.szyprowski@samsung.com>
 <CAJd=RBBPOwftZJUfe3xc6y24=T8un5hPk0wEOT_5v6WMCbDSag@mail.gmail.com>
 <op.v87mpive3l0zgt@mpn-glaptop>
Message-ID: <CAJd=RBCqw=4AEDZU5aPexX2+xVKVhB+uo-ta2hviSAJO63axvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/5 Michal Nazarewicz <mina86@mina86.com>:
> On Sun, 05 Feb 2012 05:25:40 +0100, Hillf Danton <dhillf@gmail.com> wrote:
>>
>> Without boot mem reservation, what is the successful rate of CMA to
>> serve requests of 1MiB, 2MiB, 4MiB and 8MiB chunks?
>
>
> CMA will work as long as you manage to get some pageblocks marked as
> MIGRATE_CMA and move all non-movable pages away. ?You might try and get it
> done after system has booted but we have not tried nor tested it.

Better to include whatever test results in change log.

And no more questions ;)
