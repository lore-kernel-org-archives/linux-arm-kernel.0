From: chris@zankel.net (Chris Zankel)
Date: Wed, 17 Jul 2013 00:02:10 -0700
Subject: [Linux-Xtensa] Re: sched_clock always 0 and no process time
 accounting with 3.11-rc1
In-Reply-To: <20130717064709.GD6950@tarshish>
References: <CAMo8BfLO31GgMMA_hENr0xm=qaUz3EVLtaQ8hewiQHdbV+s6sA@mail.gmail.com>
 <20130717061925.GC6950@tarshish>
 <CAMo8Bf+UY2Lj=7=Y2AxeUfM3LqJkbQqPviH81PEjwo8irtiGJg@mail.gmail.com>
 <20130717064709.GD6950@tarshish>
Message-ID: <51E64172.9050808@zankel.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 11:47 PM, Baruch Siach wrote:
>> According to C99 the behaviour of (1 << 32) is undefined on platforms with
>> 32 bit int, so it could yield any value.
> But so is ARM, isn't it?

The handling of constants might be target-architecture dependent.

On a somewhat related issue, are you using a 32-bit host or 64-bit host?
Note that 64-bit cross compilation is known to be broken for Xtensa, I
had a problem running glibc when compiled with cross compiler on a
64-bit host.

Cheers!
-Chris
