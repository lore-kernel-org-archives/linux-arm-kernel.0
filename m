From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 10 Jun 2017 01:12:22 +0900
Subject: [PATCH v5 12/20] ARM: dts: uniphier: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <CABxcv=msBQVW2P+RkcAq+5jhBkMorZvToaGDoLF6rT_knb3qhw@mail.gmail.com>
References: <20170523133448.4794-1-javier@dowhile0.org>
 <20170523133448.4794-13-javier@dowhile0.org>
 <CAK7LNATDvesYLKimY=aKfT6kAiidq6Ufd=kCWGQcCZ_Xy-27tw@mail.gmail.com>
 <CABxcv=mPzDVTh_ZH1VtuHMUhVrR+hxz8GwcQT38hwJJqHY+fJA@mail.gmail.com>
 <CAK7LNASBztX033t36vz_MXAgeyHd76roMBtRZ4mi-q9VFB4Lkg@mail.gmail.com>
 <CABxcv=msBQVW2P+RkcAq+5jhBkMorZvToaGDoLF6rT_knb3qhw@mail.gmail.com>
Message-ID: <CAK7LNASTTubkm7xV4FbcPwNCcz9TgeOswzK4Rn=FpB0oOSRmpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-06-07 21:42 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
> Hello Masahiro,
>
> On Wed, Jun 7, 2017 at 3:10 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
> [snip]
>
>>>>
>>>> Why didn't you touch
>>>> arch/arm/boot/dts/uniphier-ref-daughter.dtsi ?
>>>>
>>>
>>> Because the compatible string "microchip,24lc128" used by the I2C
>>> EEPROM node on that DTS is not supported by the
>>> drivers/misc/eeprom/at24.c driver (in fact the only occurrence for
>>> 24lc128 I see is in that DTS).
>>>
>>> Maybe is a typo and it should be "microchip,24c128" instead ?
>>
>> I do not think so.
>> I consulted a board developer.
>>
>> I also see 24LC128 on Microchip web site:
>> http://www.microchip.com/wwwproducts/en/24LC128
>>
>
> Ah Ok, it was just a wild guess I did since the at24 driver didn't
> have support for this chip variant.
> My point stands though, this is an unrelated change to the goal of
> this patch-series and should be fixed separately.
>
> Best regards,
> Javier


Applied to linux-uniphier.  Thanks!

-- 
Best Regards
Masahiro Yamada
