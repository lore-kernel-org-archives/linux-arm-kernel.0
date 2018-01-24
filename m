From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 24 Jan 2018 14:51:30 +0800
Subject: [v2,2/5] i2c: meson: add configurable divider factors
In-Reply-To: <20180124062830.vi52rtlgglryq3xz@ninjato>
References: <20171120145415.6581-3-yixun.lan@amlogic.com>
 <20180124062830.vi52rtlgglryq3xz@ninjato>
Message-ID: <600c932f-59d6-d7ec-ec02-b92b275049d5@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram?



On 01/24/18 14:28, Wolfram Sang wrote:
> On Mon, Nov 20, 2017 at 10:54:12PM +0800, Yixun Lan wrote:
>> From: Jian Hu <jian.hu@amlogic.com>
>>
>> This patch try to add support for I2C controller in Meson-AXG SoC,
>> Due to the IP changes between I2C controller, we need to introduce
>> a compatible data to make the divider factor configurable.
>>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> 
> Applied to for-next, thanks!
> 
> But I got two build warnings, please fix them with an incremental patch:
> 
> drivers/i2c/busses/i2c-meson.c:103: warning: No description found for parameter 'data'
> drivers/i2c/busses/i2c-meson.c:103: warning: Excess struct member 'irq' description in 'meson_i2c'
> 
first, many thanks for pushing this..

I understand from above warnings, and can compose a patch to fix this.

but, I didn't get this build warnings while test locally, so is there
any specific compiler option that I need to pass to?

Yixun
