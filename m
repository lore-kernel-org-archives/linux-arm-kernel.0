From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 17 Jan 2014 10:31:00 -0200
Subject: imx6dl/imx6q fec rmii mode with external ref_clk
In-Reply-To: <20140115105517.GA1776@frolo.macqel>
References: <20140114153012.GA22550@frolo.macqel>
 <20140115073536.GD1914@S2101-09.ap.freescale.net>
 <20140115094551.GA26117@frolo.macqel>
 <CAOMZO5AhTLN+aCRH0FOVFO3uoZqe=2DpSiAHO2NCCTd=yJSyHg@mail.gmail.com>
 <20140115105517.GA1776@frolo.macqel>
Message-ID: <CAOMZO5CEMsY1drx1y271w-q6q3faE3JPCsAm-HqyKARnD_ihhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 8:55 AM, Philippe De Muyter <phdm@macq.eu> wrote:
> On Wed, Jan 15, 2014 at 08:13:15AM -0200, Fabio Estevam wrote:
>> On Wed, Jan 15, 2014 at 7:45 AM, Philippe De Muyter <phdm@macq.eu> wrote:
>>
>> > Here are my patches (I have called my board imx6dl-p6-2094):
>> > Do I need to replace the hex value after MX6QDL_PAD_GPIO_16__ENET_REF_CLK
>> > by something else ?
>>
>> hummingboard uses:
>>
>> MX6QDL_PAD_GPIO_16__ENET_REF_CLK    0xc0000000
>>
>> Check arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi in linux-next.
>
> They use RGMII, while I have RMII :(

Are you able to do TFTP in the bootloader? Maybe it is easier to debug
from the bootloader and check if the PHY is being properly powered and
clocked.

You can check mx6slevk which uses RMII.

Regards,

Fabio Estevam
