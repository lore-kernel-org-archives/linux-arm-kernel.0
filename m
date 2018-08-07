From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Aug 2018 13:55:26 +0800
Subject: [PATCH v3 00/19] arm64: dts: allwinner: A64 boards DT updates
In-Reply-To: <20180731123041.33gl4zcaxlvli3to@flea>
References: <20180730123137.923-1-andre.przywara@arm.com>
 <20180731123041.33gl4zcaxlvli3to@flea>
Message-ID: <CAGb2v66hiA_sf28RX9UCEWQ1CiaizmWLUnsivSzLJ_NGnyVk8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 8:30 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, Jul 30, 2018 at 01:31:18PM +0100, Andre Przywara wrote:
>> Hi,
>>
>> only smaller changes compared to v2, addressing the comments on the
>> ML. This fixes Ethernet for the Nano Pi A64 and removes the DT nodes
>> for the non-existent BT part of this board. Also some fixes for the
>> OrangePi as requested by Maxime.
>>
>> Please note:
>> I am leaving for a three weeks holiday in a few hours, so won't be
>> able to respond or work on this.
>> Maxime, if you feel like you want to merge some parts, feel free to pick
>> some patches and/or make adjustments. Otherwise I will be picking this
>> up once I am back end of August.
>
> Apart from the serdev patch,
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

I queued up all patches except the serdev patch for 4.20.

I did a few fix ups, notably to the "Orange Pi Win USB OTG" and "NanoPi-A64
WiFi" patches. Please check the result here:

    https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/log/?h=sunxi/dt64-for-4.20

ChenYu
