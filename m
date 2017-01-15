From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jan 2017 23:50:17 +0100
Subject: [PATCH 2/4] ARM64: dts: meson-gx: add the serial CTS and RTS pin
 groups
In-Reply-To: <20170115223255.10350-3-martin.blumenstingl@googlemail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <20170115223255.10350-3-martin.blumenstingl@googlemail.com>
Message-ID: <b74ed3d7-ea69-5a5b-a313-baab3a9e2396@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.01.2017 um 23:32 schrieb Martin Blumenstingl:
> This adds pinctrl group nodes for the CTS and RTS pins of each serial
> controller. This makes it possible to enable the CTS and RTS pins which
> are controlled by the serial controller hardware (through the meson_uart
> driver).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
