From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jun 2014 09:28:36 +0800
Subject: [PATCH v3 4/4] ARM: sun8i: dt: Add Ippo-q8h v5 support
In-Reply-To: <20140623185631.GK19730@lukather>
References: <1403275973-24259-1-git-send-email-wens@csie.org>
 <1403275973-24259-5-git-send-email-wens@csie.org>
 <20140623185631.GK19730@lukather>
Message-ID: <CAGb2v67_6v-6a69eia_7eq+bVNNnYf6ngdF8GDJeeyGub-fiDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 2:56 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Jun 20, 2014 at 10:52:53PM +0800, Chen-Yu Tsai wrote:
>> The Ippo-q8h is a tablet circuit board commonly found in cheap Android
>> tablets with A23 SoCs. There are at least 2 versions of the board, with
>> different peripherals, such as WiFi chips.
>>
>> Common features among these tablets include 512 MB DRAM, NAND, MMC, LCD,
>> capacitive touchscreen, accelerometer, 1 or 2 camera sensors, USB OTG,
>> microphone and speaker.
>>
>> v5 of these board designs has a ESP8089 WiFi chip (not supported)
>> connected to mmc1. This patch adds very basic support.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Fixed the whitespace warning and applied.

Trailing newline, got it.

Thanks!
ChenYu
