From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Apr 2014 10:12:34 -0300
Subject: [PATCH 1/2] ARM: dts: imx27-pdk: Add NAND support
In-Reply-To: <1397739692.667087851@f420.i.mail.ru>
References: <1397738561-3335-1-git-send-email-festevam@gmail.com>
 <1397739692.667087851@f420.i.mail.ru>
Message-ID: <CAOMZO5A6waVSFtaT=HobuBv=-4B7bAN_zwDd-W9JRaty6XGZug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 10:01 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

>> +&nfc {
>> +     status = "okay";
>> +     nand-ecc-mode = "hw";
>> +     nand-on-flash-bbt;
>> +};
>
> You also should add pin definitions.

NAND is detected even without the pin definitions.
arch/arm/mach-imx/mach-mx27_3ds.c also does not define the NAND pins.
