From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 10:14:02 +0100
Subject: [PATCH 06/13] ARM: dts: rv1108: Add GMAC support
In-Reply-To: <20181125211907.9895-6-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-6-otavio@ossystems.com.br>
Message-ID: <1588360.6TRC2vKZya@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 25. November 2018, 22:19:00 CET schrieb Otavio Salvador:
> Add GMAC support for RV1108.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied for 4.21 after modifying the subject a bit and adding
a comment explaining that the rv1108 only has that rmii interface.

While the dwmac is definitly a big improvement over the arc-emac
it is still surprising that the gbit mac only gets a 100mbit phy interface.


Heiko
