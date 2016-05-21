From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 May 2016 15:55:06 +0200
Subject: [PATCH v2 4/5] arm64: dts: rockchip: make rk3368 grf syscons
 simple-mfds as well
In-Reply-To: <1459432126-6395-5-git-send-email-heiko@sntech.de>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
 <1459432126-6395-5-git-send-email-heiko@sntech.de>
Message-ID: <2597247.kfueRAYi3v@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 31. M?rz 2016, 15:48:45 schrieb Heiko Stuebner:
> The general register files do contain a lot of separate functions and
> while some really are only registers with a lot of different 1-bit
> settings, there are also a lot of them containing some bigger function
> blocks. To be able to define these as sub-devices, make them simple-mfds.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: David Wu <david.wu@rock-chips.com>

applied for 4.8
