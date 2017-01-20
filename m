From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 20 Jan 2017 09:53:02 -0800
Subject: [PATCH] ARM64: dts: meson-gxl: rename Nexbox A95x for consistency
In-Reply-To: <cc16a3ea-7491-a631-4587-abb25a2a235d@suse.de>
References: <20170120173843.6522-1-khilman@baylibre.com>
 <cc16a3ea-7491-a631-4587-abb25a2a235d@suse.de>
Message-ID: <CAOi56cX1NVgeHTHJDjxY0w1eQLs57_zYNHmPXS7XzO8=vWnQMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 9:45 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 20.01.2017 um 18:38 schrieb Kevin Hilman:
>> Since the GXL family has S905X and S905D SoCs, we're keeping the SoC
>> name in the DTS filename for clarity.  Rename this file accordingly to
>> be consistent with the rest of the GXL DTS files.
>>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> Reviewed-by: Andreas F?rber <afaerber@suse.de>

Applied to v4.11/dt64 with your reviewed-by.

Kevin
