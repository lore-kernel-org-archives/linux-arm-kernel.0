From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 9 Jul 2013 10:32:19 +0000
Subject: [PATCH v2] arm: dts: AM43x: Add usb_otg_hs node
In-Reply-To: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
References: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB30355@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi George,

On Tue, Jul 09, 2013 at 14:47:26, Cherian, George wrote:

> +		usb_otg_hs1: am4372_dwc3 at 48380000 {

Wouldn't "usb" a better node name ?

> +			compatible = "ti,am437x-dwc3";

Usage of wild card is discouraged per DT documentation.

Regards
Afzal
