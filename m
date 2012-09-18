From: stigge@antcom.de (Roland Stigge)
Date: Tue, 18 Sep 2012 14:13:05 +0200
Subject: [PATCH 09/19] ARM: ux500: Enable SSP (SPI) for HREF when booting
 Device Tree
In-Reply-To: <CACRpkdZLdernphVSfwHS43HptS+33=PzorihQ0bBKm689u_oFw@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaC_enpxUFNM_wteAQWKER_naUNUH-s1pJtiGzVFSV+og@mail.gmail.com>
 <505757D8.8090405@antcom.de>
 <CACRpkdZLdernphVSfwHS43HptS+33=PzorihQ0bBKm689u_oFw@mail.gmail.com>
Message-ID: <50586551.5020404@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/18/2012 02:08 PM, Linus Walleij wrote:
>> When we have sorted out this driver change (please check the new pl022
>> specific dt property names!), I will provide patches for arm-soc to
>> actually use this new interface via dts files.
> 
> OK cool I guess you will do this for the LPC32xx? Or are you testing
> this on some other platforms?

LPC32xx for now. The new code is backwards compatible, so I'd prefer for
others to adopt and test it on their platforms individually before
patching everything at once without testing.

Roland
