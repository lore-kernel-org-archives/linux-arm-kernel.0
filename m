From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Jan 2012 08:50:54 -0800
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <201201111619.05650.arnd@arndb.de>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <201201102013.54958.arnd@arndb.de>
 <20120110223712.GL7164@opensource.wolfsonmicro.com>
 <201201111619.05650.arnd@arndb.de>
Message-ID: <CAOesGMhDeN9N5A+xVGzM2aoO7YWMkxdpYxZ4o1VV42g_NP6tnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 11, 2012 at 8:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 10 January 2012, Mark Brown wrote:
>
>> I do also wonder if it's worth letting people push stuff to you
>> more aggressively - right now you seem to be asking people to batch
>> things up and I wonder if that's making it a it easier for things to end
>> up dropping on the floor if a time based routine isn't working well for
>> people.
>
> I really wish people would push stuff into arm-soc more aggressively,
> and I certainly didn't want to give the impression that maintainers
> should let their stuff sit in linux-next before sending it to us.
>
> It's absolutely fine to send multiple updates per branch for arm-soc
> as stuff comes in, as long as we can keep track of the dependencies
> and we don't have to rebase the stuff that's already merged.
>
> I would also prefer if people stopped having their own trees included
> in next, but I know that I'm sometimes slow to pick up patches that
> were submitted to arm-soc and that it helps people if they can get
> earlier integration testing that way. Hopefully we're also getting
> better at dealing with pull requests quickly so that there is no
> need for the other tree in linux-next any more.

There's value in having the vendor trees in linux-next, and the main
reason is that it's actually possible for us to see what the backlog
is. As mentioned yesterday, I'll try to diff rmk+arm-soc trees with
linux-next this upcoming staging cycle to keep track of how much is
sitting in vendor trees yet. The alternative is that they sit in a
repo somewhere that we don't even know about yet.

I also have to admit, as tegra maintainer, that it is convenient to
have my tree in linux-next, and have things show up in linux-next as
soon as I pick it up, and then send arm-soc pull requests about once a
week or so. While we should reduce latency to pull into arm-soc,
getting pull requests daily will be a bit on the heavy side.


-Olof
