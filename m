From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Jan 2017 10:58:06 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_MMC_SDHCI_CADENCE
In-Reply-To: <20170130013247.GH3133@localhost>
References: <1482718493-6792-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAR8_Aom6qZyOEV7Kd2AC_UTW3yHL_-u=6ubOBGRNhyrmQ@mail.gmail.com>
 <20170130013247.GH3133@localhost>
Message-ID: <CAK7LNAQ2z9xR+qUJqT2ZAyvan1f9HbK72GmYHVENvm36SFy3Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

2017-01-30 10:32 GMT+09:00 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Thu, Jan 26, 2017 at 06:34:21PM +0900, Masahiro Yamada wrote:
>> Hi Arnd, Olof,
>>
>>
>> 2016-12-26 11:14 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> > Enable the Cadence SD/SDIO/eMMC controller.  This is used on
>> > Socionext UniPhier SoC family.
>> >
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>>
>> Can you pick up this for ASOC, please?
>
> ASOC? ASoC is usually Audio SoC, so you should probably use arm-soc as a term
> to refer to our tree to avoid confusion.
>
> That being said -- applied.
>

Sorry, I have been misunderstanding the meaning of ASOC.
Going forward, I will say ARM-SOC.  Thanks for pointing this out!


-- 
Best Regards
Masahiro Yamada
