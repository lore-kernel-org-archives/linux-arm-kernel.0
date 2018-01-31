From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 30 Jan 2018 16:00:06 -0800
Subject: [PATCH] ARM64: dts: meson-axg: add RMII pins for ethernet
 controller
In-Reply-To: <593cbb66-7040-b27d-5109-702fb43dc18e@baylibre.com> (Neil
 Armstrong's message of "Thu, 11 Jan 2018 10:33:27 +0100")
References: <20180111030411.197054-1-yixun.lan@amlogic.com>
 <1515659863.5048.112.camel@baylibre.com>
 <2fa28259-cce9-37fc-3bcd-6017a35a052a@amlogic.com>
 <593cbb66-7040-b27d-5109-702fb43dc18e@baylibre.com>
Message-ID: <7hvafic2yh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 11/01/2018 10:11, Yixun Lan wrote:
>> Hi Jerome?
>> 
>> On 01/11/18 16:37, Jerome Brunet wrote:
>>> On Thu, 2018-01-11 at 11:04 +0800, Yixun Lan wrote:
>>>> Comparing to RGMII interface, the RMII interface require few pins.
>>>> So it's worth describing them here.
>>>>
>>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>>
>>> The only axg platform we have upstream is the s400 and is using rgmii.
>>> May I ask how this was tested ?
>>>
>> It's true that S400 using RGMII interface.
>> 
>> but, we have customer using RTL8201FR-VB/VD which is a RMII PHY,
>> 
>> This is actually tested with the 'eth_rmii_x_pins' group.
>> 
>> Yixun
>> 
>
> I pushed the same for GXBB,
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.17/dt64 with Neil's ack.

Kevin
