From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 13:52:26 -0800
Subject: [PATCH 2/4] ARM64: dts: meson-gx: add the serial CTS and RTS pin
 groups
In-Reply-To: <b74ed3d7-ea69-5a5b-a313-baab3a9e2396@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?= message of "Sun, 15 Jan 2017 23:50:17 +0100")
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <20170115223255.10350-3-martin.blumenstingl@googlemail.com>
 <b74ed3d7-ea69-5a5b-a313-baab3a9e2396@suse.de>
Message-ID: <m2k29syr1h.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Am 15.01.2017 um 23:32 schrieb Martin Blumenstingl:
>> This adds pinctrl group nodes for the CTS and RTS pins of each serial
>> controller. This makes it possible to enable the CTS and RTS pins which
>> are controlled by the serial controller hardware (through the meson_uart
>> driver).
>> 
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Tested-by: Andreas F?rber <afaerber@suse.de>

Applied to v4.11/dt64 with Andreas' ack.

Kevin
