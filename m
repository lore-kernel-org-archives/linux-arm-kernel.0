From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 9 Jul 2018 15:26:43 -0300
Subject: [PATCH 1/2] ARM: dts: imx51: Add M4IF support
In-Reply-To: <1530893834.15725.13.camel@pengutronix.de>
References: <1530720842-28281-1-git-send-email-festevam@gmail.com>
 <1530893834.15725.13.camel@pengutronix.de>
Message-ID: <CAOMZO5C_bxDwz0ZWi6g4DcqJKUT_N1oT+1XuwqcbUjwD_3BEkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Fri, Jul 6, 2018 at 1:17 PM, Lucas Stach <l.stach@pengutronix.de> wrote:

>> +                     m4if: m4if at 83fd8000 {
>> +                             compatible = "fsl,imx51-m4if";
>
> Missing documentation for this compatible.

Just sent a v2 that includes the dt-bindings doc.

Thanks
