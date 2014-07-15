From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Jul 2014 00:21:51 -0700
Subject: [PATCH 0/3] ARM: DTS: omap5-uevm: Enable audio (for 3.17)
In-Reply-To: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
References: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20140715072151.GM20068@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140710 04:26]:
> Hi,
> 
> This set is to enable audio (finally) on the omap5-uevm. We have been waiting
> for the palmas 32K clock driver to make it to upstream, which it did and it is
> already in linux-next.
> 
> With the three patch we can have audio working on omap5-uevm with linux-next.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ARM: DTS: omap5-uevm: Enable palmas clk32kgaudio clock
>   ARM: DTS: omap5-uevm: Add node for twl6040 audio codec
>   ARM: DTS: omap5-uevm: Enable basic audio (McPDM <-> twl6040)
> 
>  arch/arm/boot/dts/omap5-uevm.dts | 68 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 62 insertions(+), 6 deletions(-)

Applying into omap-for-v3.17/dt thanks.

Tony
