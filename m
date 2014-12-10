From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 10 Dec 2014 19:22:52 +0100
Subject: [PATCH v4 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <54882324.10700@rock-chips.com>
References: <1418093001-30443-1-git-send-email-lyz@rock-chips.com>
 <1418093001-30443-2-git-send-email-lyz@rock-chips.com>
 <CABgxDoJRA4cQBqNBTCSGnnLpcOHqqTuBqcyWQosVv4A_Gx315g@mail.gmail.com>
 <54882324.10700@rock-chips.com>
Message-ID: <CABgxDoKgkB2RJH-iKCqY8_wB-9K3qH-PkHNzYD6OdbeVqPt4=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> So,do you mean that I should rename the C source file as phy-rockchip-usb2.c
> ?

what I mean is that you can simply rename the kconfig entry to
PHY_ROCKCHIP_USB. If you explain that it is for usb 2.0 in the
description (as it is already the case),
it is enough, no needs to put USB2 in the kconfig entry name :)

Have a nice evening,
Romain
