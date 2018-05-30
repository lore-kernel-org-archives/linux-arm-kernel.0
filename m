From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 30 May 2018 09:50:42 -0300
Subject: [PATCH V2] soc: imx: gpcv2: correct PGC offset
In-Reply-To: <1527643842-17643-1-git-send-email-Anson.Huang@nxp.com>
References: <1527643842-17643-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5CBgrtKpGdknpwOFbdOR219JqfVJnOeEjdL1a1GiBdg=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Tue, May 29, 2018 at 10:30 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Correct MIPI/PCIe/USB_HSIC's PGC offset based on
> design RTL, the values in the Reference Manual
> (Rev. 1, 01/2018 and the older ones) are incorrect.
>
> The correct offset values should be as below:
>
> 0x800 ~ 0x83F: PGC for core0 of A7 platform;
> 0x840 ~ 0x87F: PGC for core1 of A7 platform;
> 0x880 ~ 0x8BF: PGC for SCU of A7 platform;
> 0xA00 ~ 0xA3F: PGC for fastmix/megamix;
> 0xC00 ~ 0xC3F: PGC for MIPI PHY;
> 0xC40 ~ 0xC7F: PGC for PCIe_PHY;
> 0xC80 ~ 0xCBF: PGC for USB OTG1 PHY;
> 0xCC0 ~ 0xCFF: PGC for USB OTG2 PHY;
> 0xD00 ~ 0xD3F: PGC for USB HSIC PHY;
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
