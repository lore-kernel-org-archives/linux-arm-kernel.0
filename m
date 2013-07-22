From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jul 2013 09:21:20 -0300
Subject: [PATCH 2/2] ARM: dts: mx6: Add support for imx6dl nitrogen board
In-Reply-To: <20130722075736.GC20271@S2101-09.ap.freescale.net>
References: <1374118960-19060-1-git-send-email-festevam@gmail.com>
 <1374118960-19060-2-git-send-email-festevam@gmail.com>
 <20130722075736.GC20271@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5C8Zz27KQOQxnurRmEUqUPw6VZNPGc3g4oXEUZUDxtYVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Jul 22, 2013 at 4:57 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> +/ {
>> +     model = "Boundary Devices i.MX6 Dual Lite Nitrogen Board";
>> +     compatible = "boundary,imx6dl-nitrogen", "fsl,imx6dl";
>> +
>> +     memory {
>> +             reg = <0x10000000 0x40000000>;
>> +     };
>
> This memory configuration is also common, right?

The reason I put the memory configuration in this file is because we
also have nitrogen quad and dual-lite versions with 2GB.

Regards,

Fabio Estevam
