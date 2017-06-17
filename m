From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 17 Jun 2017 19:59:31 +0200
Subject: [PATCH] soc: rockchip: disable jtag switching for RK3328 Soc
In-Reply-To: <b11e5b39-dc90-ded5-f767-4058dffa85a8@rock-chips.com>
References: <1495699104-137633-1-git-send-email-shawn.lin@rock-chips.com>
 <b11e5b39-dc90-ded5-f767-4058dffa85a8@rock-chips.com>
Message-ID: <1588999.nO53AL4emg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. Juni 2017, 16:17:45 CEST schrieb Shawn Lin:
> Hi Heiko,
> 
> Ping.... :)
> 
> On 2017/5/25 15:58, Shawn Lin wrote:
> > Disable IO function switching between sdmmc and jtag
> > for RK3328 Soc.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Ihad already applied this on thursday, just forgot to push the branch :-) .

As there was some unresolved discussion with the driver itself, we'll
see where this ends up.


Heiko
