From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 3 May 2016 09:50:04 +0530
Subject: [PATCH v2 0/3] AM57/DRA7 Clock Tree DTSI Fix-ups
In-Reply-To: <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
References: <20160427171658.GA5995@atomide.com>
 <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
Message-ID: <572826F4.3080500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 02 May 2016 10:42 PM, J.D. Schroeder wrote:
> This series of patches fixes several discrepancies between the
> AM57/DRA7 clock tree description and the actual hardware behavior and
> frequencies. With these changes a more complete picture of the clock
> tree is represented for a few of the clocks and their resulting
> frequencies.

Tested on my DRA74-evm.

Tested-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> 
> v2 Changes:
> * Rebased on linux-next as requested by Tony Lindgren
> * Eliminated previous patch 2 as another change fixing the same thing
>   was merged in eea08802f586acd6aef377d1b4a541821013cc0b
> * Added to the commit message in patch 2 to clarify the source of the
>   clock being internal to the processor
> * Added a new patch 3 to fix a new warning introduced by
>   eea08802f586acd6aef377d1b4a541821013cc0b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
