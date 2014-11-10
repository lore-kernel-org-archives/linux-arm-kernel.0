From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Nov 2014 15:30:51 -0800
Subject: [PATCH 3/4] arm: dts: omap3-gta04: Add handling for tv output
In-Reply-To: <1415051968-4878-4-git-send-email-marek@goldelico.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-4-git-send-email-marek@goldelico.com>
Message-ID: <20141110233050.GC31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [141103 14:01]:
> Add handling for gta04 tv out chain:
> venc -> opa362 -> svideo
> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 48 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Applying this patch into omap-for-v3.19/dt thanks.

Tony
