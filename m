From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 13 Jan 2014 19:13:20 +0200
Subject: [PATCH 0/2] ARM: DRA7XX/AM43XX build fixes
In-Reply-To: <20140113162412.GF26950@saruman.home>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
 <20140113162412.GF26950@saruman.home>
Message-ID: <52D41EB0.9010603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 06:24 PM, Felipe Balbi wrote:
> On Fri, Jan 10, 2014 at 11:57:28AM +0200, Tero Kristo wrote:
>> The move of clock code from mach-omap2 to drivers/clk/ti introduces
>> a couple of new build errors with AM43XX/DRA7XX only builds. The
>> following patches address these issues by modifying the Kconfig + Makefile
>> under mach-omap2.
>>
>> Also, it seems DRA7XX only build is not possible at the moment, added
>> patch #2 to fix this.
>
> looks like we still need some extra patches since OMAP2-only builds
> still fail :-(
>
> Also omap1_defconfig fails miserably :-(
>
> hoping this can still get fixed in time for 3.14 :-s

Yeah, should be simple enough to fix those... Will look at these tomorrow.

Just wondering, who cares about omap1 / omap2 anyway these days? :) 
Basically I overlooked both with the Makefile setup I did.

-Tero
