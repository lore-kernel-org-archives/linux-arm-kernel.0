From: balbes-150@yandex.ru (Oleg)
Date: Wed, 27 Sep 2017 15:30:54 +0300
Subject: [PATCH 1/2] ARM64: dts: meson-gxm: Add Vega S96 board
In-Reply-To: <a342b95d-0300-f408-266f-e48deb1f72d7@baylibre.com>
References: <1505822748-23431-1-git-send-email-narmstrong@baylibre.com>
 <1505822748-23431-2-git-send-email-narmstrong@baylibre.com>
 <1505833280.2703.83.camel@baylibre.com>
 <a79c801a-c6bc-87d6-34f5-1a52f77704c6@yandex.ru>
 <a342b95d-0300-f408-266f-e48deb1f72d7@baylibre.com>
Message-ID: <077178e6-a9a0-355d-3ca5-563e98db98ea@yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>>> +        reg = <0>;
>>>> +        max-speed = <1000>;
>>> I don't think this max-speed property is necessary
>>>
>>>> +    };
>>>> +};
>> I will try to test and write the result.
> Great, thanks !
>
> Neil
I removed two strings and checked on Vega s96,
the wired network works fine.

+&external_mdio {
+	external_phy: ethernet-phy at 0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+	};
+};
