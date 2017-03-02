From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 02 Mar 2017 09:02:06 -0800
Subject: [PATCH v5 0/9] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <1487581719.3734.1.camel@baylibre.com> (Jerome Brunet's message
 of "Mon, 20 Feb 2017 10:08:39 +0100")
References: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
 <1487581719.3734.1.camel@baylibre.com>
Message-ID: <m2varry5m9.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Sun, 2017-02-19 at 22:41 +0100, Martin Blumenstingl wrote:
>> This series adds the reset GPIOs for the (external) ethernet PHYs on
>> all
>> GXBB boards.
>> Additionally it provides a ethernet PHY node which can be used to
>> specify
>> PHY-specific properties (this may be required if more boards require
>> the
>> "eee-broken-1000t" for the RTL8211F ethernet PHY). To make all board
>> .dts
>> consistent I chose to add the PHY node also for boards which don't
>> have a
>> RTL8211F PHY.
>> 
>
> Looks good to me. For the patchset:
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
>

Applying to v4.12/dt64 with Jerome's review.

Thanks,

Kevin
