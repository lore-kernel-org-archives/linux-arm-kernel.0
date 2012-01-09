From: olof@lixom.net (Olof Johansson)
Date: Sun, 8 Jan 2012 17:21:02 -0800
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <20120108204953.GA20043@sirena.org.uk>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <CAOesGMhLE3wxM=F9OkHT-bQpsVp8Uc6eE8Uk+WN9pLuz5BRLBw@mail.gmail.com>
 <20120108204953.GA20043@sirena.org.uk>
Message-ID: <CAOesGMjn5uQEWbxrJryC+jOf=3SYbAnPY4A71NUZKFBi=a0QjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 8, 2012 at 12:49 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jan 06, 2012 at 01:58:29PM -0800, Olof Johansson wrote:
>
>> > Please pull Samsung devel for v3.3 from:
>> > ?git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> > next-samsung-devel-samsung
>
>> Thanks. I've pulled this into late/devel, based on earlier email from
>> Arnd we might end up sending this in towards the end of the merge
>> window, but there's also a chance it will wait for 3.4.
>
> That'd be extremely disappointing, especially given that there's some
> bug fixes in there for updates going in this merge window without which
> mainline is going to have problems on s3c64xx (mostly the GPIO stuff).

Of course bug fixes should go in.

Mark, Kukjin, can either of you split out the fixes in a separate branch?


Thanks,

-Olof
