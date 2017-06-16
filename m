From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 16 Jun 2017 11:40:34 -0700
Subject: [PATCH] ARM: dts: meson8: fix the IR receiver pins
In-Reply-To: <e4347b01-e221-2242-9bb9-bc1e93da06fb@baylibre.com> (Neil
 Armstrong's message of "Mon, 12 Jun 2017 09:38:55 +0200")
References: <20170609222039.25191-1-martin.blumenstingl@googlemail.com>
 <e4347b01-e221-2242-9bb9-bc1e93da06fb@baylibre.com>
Message-ID: <m2k24bg4il.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 06/10/2017 12:20 AM, Martin Blumenstingl wrote:
>> The IR receiver pins are currently defined in the CBUS pin-controller.
>> However the pins are in the AO region, which is controlled by the AOBUS
>> pin-controller. Move the pins to pinctrl_aobus so they can actually be
>> used.
>> 
>> Fixes: b60e1157d8fa ("ARM: dts: amlogic: Split pinctrl device for Meson8 / Meson8b")
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[..]

> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.13/dt with Neil's ack, will go in round 2 of pull requests
to arm-soc.

Kevin
