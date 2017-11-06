From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 6 Nov 2017 17:51:02 +0800
Subject: [PATCH] clk: meson: gxbb: fix wrong clock for SARADC/SANA
In-Reply-To: <1509959454.1328.8.camel@baylibre.com>
References: <20171106075212.14275-1-yixun.lan@amlogic.com>
 <1509959454.1328.8.camel@baylibre.com>
Message-ID: <2b3a9136-4bec-00a3-85e3-09c69d2dffc1@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome:

On 11/06/17 17:10, Jerome Brunet wrote:
> On Mon, 2017-11-06 at 15:52 +0800, Yixun Lan wrote:
>> According to the datasheet, in Meson-GXBB/GXL series,
>> The clock gate bit for SARADC is HHI_GCLK_MPEG2 bit[22],
>> while clock gate bit for SANA is HHI_GCLK_MPEG0 bit[10].
>>
>> Test passed at gxl_skt dev board.
> I think this refer to a board naming used in amlogic vendor kernel ?
> Would you mind telling what it is ?
> 

sorry, it's actually tested at gxl-s905x-p212 board.
