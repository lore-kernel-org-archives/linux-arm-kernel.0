From: ibanezchen@gmail.com (Howard Chen)
Date: Thu, 9 Oct 2014 17:39:25 +0800
Subject: [PATCH 2/3] ARM: mediatek: add dts for mt6592-evb
In-Reply-To: <1905265.b2oMdAExsA@wuerfel>
References: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
 <1412760987-1668-2-git-send-email-ibanezchen@gmail.com>
 <1905265.b2oMdAExsA@wuerfel>
Message-ID: <CAHwZioFKCmLSB52WXjq4OEkbt2UHVB+zYjKj6FZLi3AsB2WO2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 9, 2014 at 3:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 08 October 2014 17:36:26 Howard Chen wrote:
>> +/ {
>> +       model = "mt6592 evb";
>> +       compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
>> +
>> +       chosen {
>> +               bootargs = "earlyprintk console=ttyS0,921600n8";
>> +       };
>> +
>
> We're trying to get more people to use the DT earlyprintk method.
> Can you move this into a stdout-path property instead of the
> bootargs and make sure the driver supports it?

OK, It requires another patch on drivers/tty/serial/8250/8250_mtk.c.
I will discuss with Mathias, the author, about this new feature.

Thanks,
Howard
