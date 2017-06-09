From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 09 Jun 2017 11:21:45 -0700
Subject: [PATCH 2/3] arm: meson: select the clock controller for Meson8
In-Reply-To: <1496606532.3552.18.camel@baylibre.com> (Jerome Brunet's message
 of "Sun, 04 Jun 2017 22:02:12 +0200")
References: <20170604183341.21417-1-martin.blumenstingl@googlemail.com>
 <20170604183341.21417-3-martin.blumenstingl@googlemail.com>
 <1496606532.3552.18.camel@baylibre.com>
Message-ID: <m2h8zp9g3q.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Sun, 2017-06-04 at 20:33 +0200, Martin Blumenstingl wrote:
>> Select COMMON_CLK_MESON8B also for MACH_MESON8 since the Meson8b clock
>> controller driver can also be used on Meson8 SoCs now that we have a
>> separate compatible for it.
>> 
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
>

Applied to v4.13/soc with Jerome's ack.

Kevin
