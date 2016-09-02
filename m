From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 Sep 2016 13:00:16 +0200
Subject: [PATCH v4 4/6] arm64: dts: rockchip: add the gmac power domain on
 rk3399
In-Reply-To: <1472752204-8924-5-git-send-email-wxt@rock-chips.com>
References: <1472752204-8924-1-git-send-email-wxt@rock-chips.com>
 <1472752204-8924-5-git-send-email-wxt@rock-chips.com>
Message-ID: <4770120.mDmM68CBxL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 2. September 2016, 01:50:02 schrieb Caesar Wang:
> This patch supports the gmac pd to save power consumption.
> Even though some boards not need Ethernet support, the driver
> core can also take care of powering up the pd before probe.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts64 branch for 4.9 with Doug's Review-tag.

I'd like to also pick up the other two dts patches after Dave is satisfied with 
the driver-side changes in patches 1-3.


Heiko
