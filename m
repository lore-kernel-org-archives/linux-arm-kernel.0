From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 11 Jan 2018 17:11:39 +0800
Subject: [PATCH] ARM64: dts: meson-axg: add RMII pins for ethernet
 controller
In-Reply-To: <1515659863.5048.112.camel@baylibre.com>
References: <20180111030411.197054-1-yixun.lan@amlogic.com>
 <1515659863.5048.112.camel@baylibre.com>
Message-ID: <2fa28259-cce9-37fc-3bcd-6017a35a052a@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome?

On 01/11/18 16:37, Jerome Brunet wrote:
> On Thu, 2018-01-11 at 11:04 +0800, Yixun Lan wrote:
>> Comparing to RGMII interface, the RMII interface require few pins.
>> So it's worth describing them here.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> 
> The only axg platform we have upstream is the s400 and is using rgmii.
> May I ask how this was tested ?
> 
It's true that S400 using RGMII interface.

but, we have customer using RTL8201FR-VB/VD which is a RMII PHY,

This is actually tested with the 'eth_rmii_x_pins' group.

Yixun
