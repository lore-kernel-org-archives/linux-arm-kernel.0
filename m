From: fransklaver@gmail.com (Frans Klaver)
Date: Tue, 1 Sep 2015 20:21:24 +0200
Subject: [PATCH] arm: omap2: vc: fix 'or' always true warning
In-Reply-To: <20150901154609.GK4215@atomide.com>
References: <DUB128-W519E183FDD98EF80BD4CB79C6E0@phx.gbl>
 <1440756632-14043-1-git-send-email-frans.klaver@xsens.com>
 <20150901154609.GK4215@atomide.com>
Message-ID: <CAH6sp9NLgiFGU8yDsxjYgu6ZUeyTvduwueF60VEgMeMi5dmEDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 1, 2015 at 5:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Frans Klaver <frans.klaver@xsens.com> [150828 03:14]:
>> From: Frans Klaver <fransklaver@gmail.com>
>>
>> Fix the warning:
>> arch/arm/mach-omap2/vc.c:302:47: warning: logical ?or? of collectively exhaustive tests is always true [-Wlogical-op]
>>
>> As we're toggling both CLKREQ and OFFMODE, we should also be checking
>> OFFMODE.
>>
>> Signed-off-by: Frans Klaver <fransklaver@gmail.com>
>
> Thanks apppying into omap-for-v4.3/fixes.

Thanks!

Frans
