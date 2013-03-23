From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 23 Mar 2013 23:19:30 +0100
Subject: [GIT PULL] sunxi drivers additions for 3.10, take 1
In-Reply-To: <201303231006.02970.arnd@arndb.de>
References: <514D7B30.7080002@free-electrons.com>
 <201303231006.02970.arnd@arndb.de>
Message-ID: <514E2A72.80707@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Le 23/03/2013 11:06, Arnd Bergmann a ?crit :
> On Saturday 23 March 2013, Maxime Ripard wrote:
>> Please consider pulling the following pull request that contains
>> drivers to be included in 3.10. The only addition for now is the clock
>> driver for the Allwinner A10 and A13.
>>
> 
> Hi Maxime,
> 
> I see the patches have been Acked by Mike Turquette, so I assume he's
> ok with getting them merged through the arm-soc tree, but I don't
> actually see a reason why it shouldn't just go through his tree.
> If there is something I'm missing, that is probably information
> that belongs into the tag description.
> 
> I don't mind pulling this if there is a good reason, such as later
> pull requests for 3.10 depending on it, but I'd prefer to not just
> get a pull request for something that is not in my area without
> an explanation why that is necessary, and without having the
> real subsystem maintainer on Cc.

There will probably be further merge depending on this, but I don't
think there will be more than clock gates patches and some rework that I
plan to begin support for the next chip, so I'm fine with it going
through Mike's tree.

I just took it in my tree to avoid similar merge problems than the one
we encountered, and since I had to merge some of the patches in this
series...

Anyway, like I said, if you prefer to see this going through Mike's
tree, I'm fine with it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
