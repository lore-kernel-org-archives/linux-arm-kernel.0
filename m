From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 11 Sep 2018 15:28:52 +0200
Subject: [PATCH] arm64: dts: meson-axg-s400: Add chosen and memory nodes
In-Reply-To: <CAFBinCDeHVZ5s2f5xhuRByg7pt+MTqqfO8_5C_s_B3hbZkDANg@mail.gmail.com>
References: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com>
 <CAFBinCDeHVZ5s2f5xhuRByg7pt+MTqqfO8_5C_s_B3hbZkDANg@mail.gmail.com>
Message-ID: <b7118d22-45f7-d509-70fe-a2923a0b78ff@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 10/09/2018 20:45, Martin Blumenstingl wrote:
> On Mon, Sep 10, 2018 at 8:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add missing chosen and memory nodes.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> out of curiosity:
> - does the bootloader add the memory node (meaning that this is just a
> cosmetic bit)?

Yes, but it's always better to already have the node so it only change the memory,
otherwise it has to relocate and insert a node in the middle of the dtb.

> - setting stdout-path is always a good idea, without it you can't use
> earlycon (without parameters)
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 

Thanks,
Neil
