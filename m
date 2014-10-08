From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 8 Oct 2014 21:41:18 +0800
Subject: [PATCH v3 3/5] ARM: dts: sun9i: Add A80 Optimus Board support
In-Reply-To: <54353CE5.5070808@gmail.com>
References: <1412773376-25212-1-git-send-email-wens@csie.org>
 <1412773376-25212-4-git-send-email-wens@csie.org> <54353CE5.5070808@gmail.com>
Message-ID: <CAGb2v65bPWvcs8CkOVgUhRRfhU6dz=WDt98wRMAjD+Hb3wbk8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 8, 2014 at 9:32 PM, Dinh Nguyen <dinh.linux@gmail.com> wrote:
>
>
> On 10/8/14, 8:02 AM, Chen-Yu Tsai wrote:
>> The A80 Optimus Board is was launched with the Allwinner A80 SoC.
>> It was jointly developed by Allwinner and Merrii.
>>
>> This board has a UART port, a JTAG connector, USB host ports, a USB
>> 3.0 OTG connector, an HDMI output, a micro SD slot, 8G NAND flash,
>> 4G DRAM, a camera sensor interface, a WiFi/BT combo chip, a headphone
>> jack, IR receiver, and additional GPIO headers.
>>
>> This patch adds only basic support.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/Makefile              |  2 +
>>  arch/arm/boot/dts/sun9i-a80-optimus.dts | 66 +++++++++++++++++++++++++++++++++
>>  2 files changed, 68 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun9i-a80-optimus.dts
>>
> [...]
>> +
>> +/dts-v1/;
>> +/include/ "sun9i-a80.dtsi"
>> +
>> +/ {
>> +     model = "Merrii A80 Optimus Board";
>> +     compatible = "merrii,a80-optimus", "allwinner,sun9i-a80";
>
> "merrii" should be added to vendor-prefixes.txt

A patch for that was already queued by Maxime.

ChenYu
