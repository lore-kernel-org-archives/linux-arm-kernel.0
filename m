From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 19 Sep 2016 09:42:22 -0700
Subject: [PATCH v2 3/6] phy: meson: add USB2 PHY support for Meson8b and
 GXBB
In-Reply-To: <57DCC3CF.9090409@ti.com> (Kishon Vijay Abraham, I's message of
 "Sat, 17 Sep 2016 09:47:19 +0530")
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-4-martin.blumenstingl@googlemail.com>
 <m2a8faxy72.fsf@baylibre.com> <57DCC3CF.9090409@ti.com>
Message-ID: <m2wpi7hmdt.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishon Vijay Abraham I <kishon@ti.com> writes:

> Hi Kevin,
>
> On Wednesday 14 September 2016 09:36 PM, Kevin Hilman wrote:
>> Kishon,
>> 
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>> 
>>> This is a new driver for the USB PHY found in Meson8b and GXBB SoCs.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>> 
>> Will you be picking this up for v4.9?
>
> It's already late for 4.9. Generally send pull request to Greg around -rc6.
> This can go only in 4.10.

That's fine.

Does that mean you have it queued someplace?  I don't see it in any of
your branches.

Kevin
