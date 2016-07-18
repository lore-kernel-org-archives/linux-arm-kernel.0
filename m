From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 18 Jul 2016 21:46:19 +0200
Subject: [PATCH] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <1468855952-2006-2-git-send-email-ayaka@soulik.info>
References: <1549971.ctkvOGm2xW@diego>
 <1468855952-2006-1-git-send-email-ayaka@soulik.info>
 <1468855952-2006-2-git-send-email-ayaka@soulik.info>
Message-ID: <2868781.4x2gJCRbLH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 18. Juli 2016, 23:32:32 schrieb Randy Li:
> The Firefly RK3288 Reload is a combination Firefly rk3288 core board
> with the Reload baseboard. Add a dtsi for the Firefly rk3288 core
> which can be included into the dts for the various baseboards
> in the future and dts for Reload base board.
> 
> Currently supported are serial console, wired networking, eMMC and
> SD storage, SPFIF, IR receiver, LEDs, SDIO wifi and USB. But only
> the OTG could work on the host mode now, the other USB host can't
> work now, additional patches are required.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> Acked-by: Rob Herring <robh@kernel.org>

applied [0], after some minor reordering - please double check.

Also, while the branch is named 4.8 this will only go into 4.9, as the merge-
window supposedly opens on the weekend.


Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=e00fdd4931ea4c47f53cba59b7a3800677546bea
