From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 8 Jun 2016 10:49:39 +0300
Subject: [PATCH v3 2/4] ARM: dts: imx6q: extend support for the cm-fx6
In-Reply-To: <1bf474715cdf430a811ba16c82ce6f25@rwthex-s1-b.rwth-ad.de>
References: <20160607171418.1703-1-christopher.spinrath@rwth-aachen.de>
 <1bf474715cdf430a811ba16c82ce6f25@rwthex-s1-b.rwth-ad.de>
Message-ID: <5757CE13.7040005@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2016 08:14 PM, christopher.spinrath at rwth-aachen.de wrote:
> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> 
> The cm-fx6 module has an on-board spi-flash chip for its firmware, an
> eeprom (containing e.g. the mac address of the on-board Ethernet),
> a sata port, a pcie controller, an USB hub, and an USB otg port.
> Enable support for them. In addition, enable syscon poweroff support.
> 
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
