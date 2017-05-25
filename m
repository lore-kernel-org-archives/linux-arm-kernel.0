From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Thu, 25 May 2017 11:38:08 +0300
Subject: [PATCH v2 1/2] ARM: dts: orange-pi-zero: specify wifi interrupts
In-Reply-To: <DAC099FE-6655-4EE2-A68A-AD2C5BBDDF76@aosc.io>
References: <20170524212433.14386-1-geomatsi@gmail.com>
 <20170524212433.14386-2-geomatsi@gmail.com>
 <CAGb2v647GTQW9-ZYrkWS7RoeYTu_7oTm8v4PDs0YD1pZ8oUohQ@mail.gmail.com>
 <20170525071055.xdd4sbpnzlkg7wa2@speedy.hunter>
 <CAGb2v671hWDaTqCAJiN0JAuiPynW+=XtN+Xr5WiyTPDSkk9-FQ@mail.gmail.com>
 <DAC099FE-6655-4EE2-A68A-AD2C5BBDDF76@aosc.io>
Message-ID: <CAFGfvX79A0+Q3iPgfQ8tDG5BX78Gp_PCtbsk8ogiSCd9fC+mug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> Those properties are optional. Driver works anyway, though it
>>complains about
>>> missing interrupts. IIUC xradio driver falls back to polling mode
>>only if
>>> xr819 interrupt configuraton is not specified.
>>
>>So it doesn't support in-band SDIO interrupts right now. Is that a
>>hardware
>>or driver limitation?
>
> The original driver code modified by me to mainline uses in-band interrupts.
>
> But dgp modified it to use out-of-band interrupts.

Current patch was intended to simplify using out of the box the following
out-of-tree driver: https://github.com/fifteenhex/xradio.

Could you please share a bit more details about the drivers you mention here.
Is there any xr819 mainlining efforts ongoing ?

Regards,
Sergey
