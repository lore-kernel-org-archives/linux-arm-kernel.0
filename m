From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 May 2018 11:56:01 -0700
Subject: [PATCH v2] ARM: AM43XX: Add functions to save/restore am43xx
 control registers
In-Reply-To: <1527013299-7982-1-git-send-email-j-keerthy@ti.com>
References: <1527013299-7982-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20180523185601.GU98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180522 11:24]:
> From: Tero Kristo <t-kristo@ti.com>
> 
> These registers are part of the wkup domain and are lost during RTC only
> suspend and also hibernation, so storing/restoring their state is
> necessary.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Introduced cpu_pm notifier instead of direct calls from pm33xx code.
>   * Tested on am437x-gp-evm
> 
> Probably too late for 4.18!

Applying into omap-for-v4.18/soc thanks, let's see if we can still
make it. If not, then for v4.19.

Regards,

Tony
