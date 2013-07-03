From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Jul 2013 17:00:43 -0700
Subject: [GIT PULL 3/7] ARM SoC specific changes
In-Reply-To: <CA+55aFzV12kJgNOax7B1rM8capK2uYLH66wHnQRNn4k5wa1LMQ@mail.gmail.com>
References: <201307022055.50717.arnd@arndb.de>
 <201307022104.01826.arnd@arndb.de>
 <20130702231706.GF24642@n2100.arm.linux.org.uk>
 <CA+55aFzV12kJgNOax7B1rM8capK2uYLH66wHnQRNn4k5wa1LMQ@mail.gmail.com>
Message-ID: <CAOesGMifPRVr=TVWJfEOm83tMVE0aXFCBVNvAKLV8mvqbDEJmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 2, 2013 at 4:51 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jul 2, 2013 at 4:17 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> Please don't merge this yet.
>
> Oops, too late. The ARM SoC pull requests got merged a couple of hours ago..

It should hopefully not be a big problem, you'll see a merge conflict
(so will sfr) when merging from Russell due to add/add conflicts been
resolved by ordering them in opposite order in
arch/arm/include/asm/glue-proc.h.

Feel free to flip them back to Russell's preferred ordering at that
time, of course.


-Olof
