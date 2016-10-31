From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Oct 2016 15:30:29 +0100
Subject: [PATCH 0/3] ARM: dts: oxnas: Update support for OX820 and use
 dt-bindings
In-Reply-To: <CAOesGMjsjYPKyH2CD4siZmB3F64h+c7vndfjFdniTDLB4Eh4Pw@mail.gmail.com>
References: <20161021151037.20112-1-narmstrong@baylibre.com>
 <fce063fd-6aaa-8d30-1588-e656e93bdebc@baylibre.com>
 <CAOesGMjsjYPKyH2CD4siZmB3F64h+c7vndfjFdniTDLB4Eh4Pw@mail.gmail.com>
Message-ID: <70b8ca3b-3756-05ba-0821-f8fd5b51dc62@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 10/31/2016 03:24 PM, Olof Johansson wrote:
> Hi,
>>
>> Hi,
>>
>> I'm ready to send a pull request for arm-soc-dt, but I need to understand how this dependency
>> should be worked out.
>>
>> Should this be sent as a late pull request ?
> 
> 
> The need for dt-include changes is one of my pet peeves these days,
> since they require coordination between trees.
> 
> There's two ways to solve this:
> 
> 1) Make sure that the branches you sent to other maintainers are
> stable, that they merge them as-is and don't rebase. This is a
> three-way handshake (we want to be cc:d on it). Then base your branch
> on top of those two branches.

It may be possible, at least from the clock tree.

Anyway, it's good to know, if I had a single tree to synchronize with,
I'll eventually select this option...

> 
> or:
> 
> 2) Avoid using the includes now, using numerical constants instead.
> Then, after next merge window, follow up with a patch that converts to
> symbols.

I will select this option for now, my ultimate goal is to have something booting
for 4.10, cleanup can really wait 4.11...

> 
> -Olof
> 


Thanks,

Neil
