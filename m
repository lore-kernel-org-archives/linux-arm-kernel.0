From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 Oct 2013 00:21:08 +0530
Subject: [PATCH v2 1/2] ARM: dts: dra7-evm: Add mmc1 node for micro-sd
 support
In-Reply-To: <1381163104-6318-1-git-send-email-balajitk@ti.com>
References: <1381163104-6318-1-git-send-email-balajitk@ti.com>
Message-ID: <5255A59C.5040301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 October 2013 09:55 PM, Balaji T K wrote:
> Add mmc1 dt node to dra7-evm board.
> Input for ldo1 regulator is controlled by gpio 5 of pcf8575 chip (0x21)
> on i2c1 bus. When dt support for gpio-pcf857x is available, input supply
> will be modelled as cascaded regulator.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
