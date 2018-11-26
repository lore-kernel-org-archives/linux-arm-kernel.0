From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 10:03:15 +0100
Subject: [PATCH v2] ARM: dts: rv1108: enable eMMC support
In-Reply-To: <20181125211427.4926-1-otavio@ossystems.com.br>
References: <20181125211427.4926-1-otavio@ossystems.com.br>
Message-ID: <2374110.cSv9E7W1qs@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 25. November 2018, 22:14:27 CET schrieb Otavio Salvador:
> Enable eMMC support for rv1108.dtsi as it can be used across multiple
> boards.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied for 4.21 after reordering the emmc pinctrl nodes a bit
and modifying the suject + commit message to be a bit more specific
in that we only add the common pin settings.


Heiko
