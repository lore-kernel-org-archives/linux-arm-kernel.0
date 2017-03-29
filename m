From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 29 Mar 2017 13:50:15 -0500
Subject: [PATCH 0/8] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
In-Reply-To: <20170329171314.GD10760@atomide.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
 <20170329171314.GD10760@atomide.com>
Message-ID: <cd340d7a-c0cf-9227-1382-2277ffa5b1b0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,
On 03/29/2017 12:13 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [170328 19:00]:
>> Hi,
>> This series contains the remaining code to enable suspend to mem and standby on
>> am335x and am437x platforms. It depends on the ti-emif-sram series sent here [1].
>
> Looks good to me in general. To remove the dependency, can some
> of this be merged separately without breaking things before [1]?
> Maybe by disabling some of the PM states until [1] is in place?

Thanks for the feedback. Actually, patch 7 is the only patch with a dependency 
to [1]. The rest of the patches just add platform PM support needed for suspend 
but won't do much of anything until patch 7 actually enables the suspend states, 
so there is no reason why patches 1-6 and patch 8 can't be merged now.

Regards,
Dave

>
> Regards,
>
> Tony
>
