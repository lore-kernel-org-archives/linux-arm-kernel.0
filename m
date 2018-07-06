From: martin@lucina.net (Martin Lucina)
Date: Fri, 6 Jul 2018 17:01:07 +0200
Subject: [PATCH 04/10] arm64: dts: allwinner: a64: Olinuxino: add
 Ethernet nodes
In-Reply-To: <20180706085210.17952-5-andre.przywara@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-5-andre.przywara@arm.com>
Message-ID: <20180706150107.i76seghldrw5flr3@nodbug.lucina.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, 06.07.2018 at?09:52, Andre Przywara wrote:
> Add the DT nodes required to enable the Gigabit Ethernet on the board.
> The PHY is powered by the always-on power rail VDD_SYS_3.3V (DCDC1).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

This may not be directly related to just the DT, but:

While this patch does result in detecting and enabling the onboard Ethernet
correctly, I am failing to successfully transmit any packets. Receive does
work.

For details see this thread:
https://groups.google.com/forum/#!topic/linux-sunxi/J9w_gXYVRgw

-mato
