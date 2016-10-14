From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 14 Oct 2016 16:18:06 +0200
Subject: [PATCH v2] ARM: dts: rockchip: temporarily remove emmc hs200
 speed from rk3288-veyron-speedy.
In-Reply-To: <87twd1vzc5.fsf@aikidev.net>
References: <87twd1vzc5.fsf@aikidev.net>
Message-ID: <1556360.cZVpdmzNha@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 27. September 2016, 13:53:46 CEST schrieb Vagrant Cascadian:
> This essentially mimics what was done with rk3288-veyron-minnie in
> commit 984926781122f034d5bc9962815d135b6c4a8e1d.
> 
> The eMMC of the speedy Chromebook also appears to need the same tuning
> workaround, as it frequently fails to recognize the eMMC without it.
> 
> Signed-off-by: Vagrant Cascadian <vagrantc@aikidev.net>

applied as fix for 4.9.

Your mail client mangled that patch a lot (tabs etc), so it didn't apply 
cleanly. As it is a quite small one, I fixed that up myself, but please try to 
make your mail client send correct patches in the future or use git send-email 
:-)


Thanks
Heiko
