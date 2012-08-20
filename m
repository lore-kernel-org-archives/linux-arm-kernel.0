From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 20 Aug 2012 14:13:41 +0200
Subject: [PATCHv3 0/4] Add device tree data for omap5
In-Reply-To: <CAKdam57L8txFtE9ahy3u3vLW0XRP5z4QaNQKVFj9KaEFZE1qvg@mail.gmail.com>
References: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
 <CAKdam57L8txFtE9ahy3u3vLW0XRP5z4QaNQKVFj9KaEFZE1qvg@mail.gmail.com>
Message-ID: <503229F5.4030405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2012 02:10 PM, Poddar, Sourav wrote:
> Hi All,
> 
> On Tue, Aug 14, 2012 at 9:54 PM, Sourav Poddar <sourav.poddar@ti.com> wrote:
>> The following patch series add i2c support for omap5.
>> As well as enable I2C based devices like pressure and temperature
>> through device tree. Also add onchip keypad dts data.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Sourav Poddar (4):
>>   arm/dts: omap5-evm: Add I2C support
>>   arm/dts: omap5-evm: Add tmp102 sensor support
>>   arm/dts: omap5-evm: Add keypad data
>>   arm/dts: omap5-evm: Add bmp085 sensor support
>>
>> v2->v3
>> - Rebased on 3.6-rc1
>> - Add comments for tmp102 and bmp085
>>  arch/arm/boot/dts/omap5-evm.dts |   32 +++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 72 insertions(+), 0 deletions(-)
>>
> Any comment on this series?

Didn't we mentioned updating the trivial-devices.txt in the
documentation to list these devices?

Otherwise it it fine. You can add the documentation and I'll take these
patches as well along with the others.

Regards,
Benoit
