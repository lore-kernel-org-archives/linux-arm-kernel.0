From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Apr 2018 20:24:51 +0800
Subject: [PATCH v2 2/2] arm64: dts: allwinner: Add dts file for Libre
 Computer Board ALL-H3-CC H5 ver.
In-Reply-To: <20180424121440.qmiubwdgcisn4g4m@flea>
References: <1524570434-17814-1-git-send-email-narmstrong@baylibre.com>
 <1524570434-17814-3-git-send-email-narmstrong@baylibre.com>
 <20180424121440.qmiubwdgcisn4g4m@flea>
Message-ID: <CAGb2v65-SOfhf0B-cJhY-9bCWnFuw_r-c19TW0p9kcs7043McQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 8:14 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Apr 24, 2018 at 01:47:14PM +0200, Neil Armstrong wrote:
>> The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
>> Pi B+ form factor single board computer based on the Allwinner H2+, H3,
>> or H5 SoCs with the same PCB.
>> The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes

The board has 2GB DDR3 SDRAM, provided by 4 4Gb chips. Copy-paste error?

>> and connectors are in the exact same position as on the Raspberry Pi B+.
>>
>> This patch enables the H5 variant using the H3 board definition moved to
>> a common dtsi in an earlier patch. The dts sinmply include the common dtsi

                                              ^ Small typo here.

ChenYu

>> and declares the correct compatible and model of the H5 variant.
>>
>> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
