From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 8 Jun 2016 10:29:55 +0300
Subject: [PATCH 2/3] ARM: dts: imx7d: move input header into base device
 tree
In-Reply-To: <20160608023709.32090-3-stefan@agner.ch>
References: <20160608023709.32090-1-stefan@agner.ch>
 <20160608023709.32090-3-stefan@agner.ch>
Message-ID: <5757C973.1030906@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 06/08/2016 05:37 AM, Stefan Agner wrote:
> The base device tree uses KEY_POWER in the snvs-powerkey node,
> hence include the input.h header file in the base device tree.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Seems very reasonable.

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
