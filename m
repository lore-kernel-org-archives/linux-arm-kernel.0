From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 2 Dec 2017 20:00:09 -0800
Subject: [PATCH 6/6] ARM: configs: keystone_defconfig: Enable few
 peripheral drivers
In-Reply-To: <20171123075154.3938-7-vigneshr@ti.com>
References: <20171123075154.3938-1-vigneshr@ti.com>
 <20171123075154.3938-7-vigneshr@ti.com>
Message-ID: <fb0c662b-d462-c663-7cf0-443ace3565ba@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/17 11:51 PM, Vignesh R wrote:
> Enable drivers for QSPI, LEDS, gpio-decoder that are present on 66AK2G EVM
> and 66AK2G ICE boards.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
Please submit a patch also to enable all these peripherals
in multi-v7 config. Just enable all remainder
options enabled in keystone config also in multi-v7.

Am pushing this series to next now.

Regards,
Santosh
