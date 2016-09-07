From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 7 Sep 2016 23:32:38 +0200
Subject: [PATCH 1/7] clk: gxbb: expose USB clocks
In-Reply-To: <20160907003355.GQ12510@codeaurora.org>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-2-martin.blumenstingl@googlemail.com>
 <20160907003355.GQ12510@codeaurora.org>
Message-ID: <CAFBinCBwcVkXi9wVt1FGaEFdK+fsxz-r12ao89HwqozqLGtd7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 2:33 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/04, Martin Blumenstingl wrote:
>> USB0_DDR_BRIDGE and USB1_DDR_BRIDGE1 are needed for the related
>> dwc2 usb controller. USB, USB0 and USB1 are needed for the PHYs.
>> Expose these clocks to DT and comment out in clk driver.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Is authorship correct on this patch? Did Jerome author it
> instead?
We (Jerome and I) have both worked on this patch, that's why you have
two signed-off-by's.
Or is this simply about the order (author = from address should be
listed first)?


Regards,
Martin
