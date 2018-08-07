From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Aug 2018 13:09:48 +0800
Subject: [PATCH v3 07/19] arm64: dts: allwinner: a64: Orange Pi Win: Add
 UARTs
In-Reply-To: <CAGb2v66ZDyW18RzJrC1x_JNcqwKZ-jXKFYtmBMxDrgKXTvaahw@mail.gmail.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
 <20180730123137.923-8-andre.przywara@arm.com>
 <CAGb2v66ZDyW18RzJrC1x_JNcqwKZ-jXKFYtmBMxDrgKXTvaahw@mail.gmail.com>
Message-ID: <CAGb2v646xPByD2Xo_Y4Hq9wExDJ4v2BH89bV4MwJ8vYX5fnbvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 1:08 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Jul 30, 2018 at 8:31 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>> From: Samuel Holland <samuel@sholland.org>
>>
>> The Orange Pi Win exposes several UARTs on header pins, and connects one
>> to the on-board WiFi/Bluetooth chip.
>>
>> Add the pinmux definitions to the UART nodes, but keep them disabled.
>> Enable the UART1, which is wired to the Bluetooth chip, and add a serdev
>> node. There is no binding for the BT8723 yet, so leave this mostly empty
>> for now.
>
> The latter part regarding Bluetooth no longer applies. Queued with this
> part removed.

Misread the patch. It still applies, so applied as is.

ChenYu
