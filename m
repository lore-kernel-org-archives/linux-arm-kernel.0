From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 19 Oct 2016 09:12:37 -0700
Subject: [PATCH v4] MMC: meson: initial support for GX platforms
In-Reply-To: <CAPDyKFps2QYq9N1erqDdCnmXJyUT60HLQDe8+gR7A571-F8NLg@mail.gmail.com>
 (Ulf Hansson's message of "Wed, 19 Oct 2016 09:19:43 +0200")
References: <20161018195605.21145-1-khilman@baylibre.com>
 <CAPDyKFps2QYq9N1erqDdCnmXJyUT60HLQDe8+gR7A571-F8NLg@mail.gmail.com>
Message-ID: <7hvawo8gi2.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 18 October 2016 at 21:56, Kevin Hilman <khilman@baylibre.com> wrote:
>> Initial support for the SD/eMMC controller in the Amlogic S905/GX*
>> family of SoCs.
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> Changes from v3:
>> - better handling of clock error paths
>> - rename to meson-gx to reflect support for newer SoCs
>> - has now been tested with SDIO
>>
>>  .../devicetree/bindings/mmc/amlogic,meson-gxbb.txt |  33 +
>
> Just realize this. You should split the DT doc into a separate patch,
> such the DT maintainers can ack it.

OK, I separated out the binding and sent a v5.

> Otherwise this looks good to me!

Thanks for the review!

Kevin
