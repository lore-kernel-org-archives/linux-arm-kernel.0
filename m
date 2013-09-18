From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Sep 2013 14:45:41 -0600
Subject: [PATCH 00/26] ARM: provide common arch init for DT clocks
In-Reply-To: <523A046E.6040804@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130918194711.GR19937@titan.lakedaemon.net> <523A046E.6040804@gmail.com>
Message-ID: <523A10F5.7090009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 01:52 PM, Sebastian Hesselbarth wrote:
> On 09/18/2013 09:47 PM, Jason Cooper wrote:
>> On Wed, Sep 18, 2013 at 07:53:33PM +0200, Sebastian Hesselbarth wrote:
>> ...
>>> Sebastian Hesselbarth (26):
>>>    ARM: nomadik: move mtu setup to clocksource init
...
>>
>> How would you like to handle this series?
> 
> Jason,
> 
> honestly I don't really know, yet. I was hoping for Arnd and Olof
> decide on that. Maybe they also create a topic branch up to where
> arch-wide of_clk_init is introduced. Then each removal patch can
> go through the independent sub-trees. There may be more machs
> introduced before, that can then also depend on the common branch.

Oh, I was assuming you'd just take the whole thing through one tree,
likely in arm-soc. That's why I created the topic branch for the Tegra
PMIC patch that's a dependency of this... However, I guess if you just
merge the core into a topic branch in arm-soc and everyone merges it
back, that's fine. I assume the Tegra topic branch I created won't be
necessary in that case.
