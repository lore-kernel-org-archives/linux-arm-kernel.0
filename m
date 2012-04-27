From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Apr 2012 14:37:12 +0200
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add SPI NOR support
In-Reply-To: <CAOMZO5DLwrKJQjZD3RWptd4TjUHq=4HLopnzZbFRFvB60pm8XA@mail.gmail.com>
References: <1335310537-11219-1-git-send-email-festevam@gmail.com>
 <20120427034401.GE2234@S2101-09.ap.freescale.net>
 <CAOMZO5DLwrKJQjZD3RWptd4TjUHq=4HLopnzZbFRFvB60pm8XA@mail.gmail.com>
Message-ID: <CACRpkdaWZcGXDz3gn7X88+Bbu-u6snpuxbR6f=MmhDSP9KmfpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 5:51 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Apr 27, 2012 at 12:44 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
>> I applied both patches and see the following modprobe error message
>> with my testing. ?Any relevance, or I missed something?
>>
>> spi_imx 2008000.ecspi: master is unqueued, this is deprecated
>
> This happens in imx-spi driver and I have reported it in the spi-devel list:
> http://www.mail-archive.com/spi-devel-general at lists.sourceforge.net/msg08019.html

Sorry for missing to reply on your mail on how to fix it, will do that now!

Yours,
Linus Walleij
