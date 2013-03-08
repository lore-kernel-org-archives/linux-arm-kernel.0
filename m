From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 08 Mar 2013 13:39:50 +0100
Subject: [PATCH] ARM: mach-bcm: drop "select GENERIC_TIME"
In-Reply-To: <CAGFynZ-CBRMGAwgF+xjAU_R8QPHhS_wtQgxgmW9JPVsjohOi2w@mail.gmail.com>
References: <1362563553.16460.166.camel@x61.thuisdomein>
 <CAGFynZ-CBRMGAwgF+xjAU_R8QPHhS_wtQgxgmW9JPVsjohOi2w@mail.gmail.com>
Message-ID: <1362746390.5994.62.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-07 at 19:18 -0800, Christian Daudt wrote:
> My bad. Thanks for the fix !
> 
> Reviewed-by: Christian Daudt <csd@broadcom.com>

In the same commit, 8ac49e0485bb79223a111b366a3b1f5ec9148729 ("Add
support for generic BCM SoC chipsets"), you also added
    select GPIO_BCM

There's currently no Kconfig symbol by that name. Is it perhaps needed
for future enhancements?


Paul Bolle
