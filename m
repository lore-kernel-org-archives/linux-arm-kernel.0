From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 23 May 2014 01:14:59 +0200
Subject: [PATCH v4 0/7] ARM: berlin: add pinctrl support
In-Reply-To: <CACRpkda6-W6rNXtAbcTs6dgp4WLExXra6P_dqQbuYsRWi7MaOw@mail.gmail.com>
References: <1400520995-27365-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkda6-W6rNXtAbcTs6dgp4WLExXra6P_dqQbuYsRWi7MaOw@mail.gmail.com>
Message-ID: <537E84F3.6020207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2014 12:11 AM, Linus Walleij wrote:
> On Mon, May 19, 2014 at 7:36 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
> 
>> but can you please drop the Berlin pinctrl patches
>> and reconsider taking the reworked driver instead?
> 
> Sure I applied patches 1 thru 4 to the pin control tree.
> The rest you need to carry in some ARM SoC tree or
> similar.

Great, thanks. Having it in is a huge benefit as future device
drivers will depend on at least some pinctrl. Functionally it is
ok, Mike's request for clock node rework smashed my time schedule.

> I don't mind the driver being half-merged like this, because
> it means we can work on consolidating the utils code
> in the next cycle.

Sure, pinctrl properties consolidation is on my list for next
cycle.

Anyway, sorry for the late mess with it, I am still learning on
the first real arm/mach-maintainer cycle.

Sebastian
