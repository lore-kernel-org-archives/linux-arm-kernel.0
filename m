From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Tue, 28 Apr 2015 21:36:17 +0200
Subject: [PATCH] arch/arm/mm/proc-arm925.S: remove dead #ifdef block
In-Reply-To: <1430249097.2411.74.camel@x220>
References: <1430239529-15726-1-git-send-email-valentinrothberg@gmail.com>
 <1430249097.2411.74.camel@x220>
Message-ID: <CAD3Xx4KDNTb6EFfeSOW_-cL0owvjAkNDR8+A3StHHZW6LNgYkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 9:24 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Tue, 2015-04-28 at 18:45 +0200, Valentin Rothberg wrote:
>> The block could never be compiled;  CPU_ICACHE_STREAMING_DISABLE has not
>> been defined in Kconfig since the very first Git commit.
>
> Actually, this goes back to a patch titled "1759/1: Add ARM925 support,
> updated" that landed in v2.6.4.
>
> When cleaning up ancient cruft like this it's fun, at least I think it
> is, and possibly even informative, to have a Linux history repository at
> hand. Feel free to prod me for details how to create such a repository.

Thanks!  I just wanted to point out that this code hasn't been touched
since I was at high school : )  Do you link the repositories or do you
have a separate history repo?

Thanks,
 Valentin

> Paul Bolle
>
