From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 5 Nov 2016 10:48:12 -0200
Subject: Low network throughput on i.MX28
In-Reply-To: <1478349578.3405.5.camel@intel.com>
References: <1476313753.2065.11.camel@embedded.rocks>
 <20161013084807.6a231fdb@ipc1.ka-ro>
 <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
 <20161014081349.1afb22c6@ipc1.ka-ro>
 <1476521171.1670.2.camel@embedded.rocks>
 <2131339088.8778.d47a56f6-921e-4d6c-9a5c-2e77bfd5d281.open-xchange@email.1und1.de>
 <8C3BD5BA-252F-4A95-B938-50356A23974E@embedded.rocks>
 <2003579366.391192.0cc5acd0-af27-4ef7-892f-3c2dd86176ba.open-xchange@email.1und1.de>
 <1477696028.31471.3.camel@embedded.rocks>
 <1143135945.89173.6f7a3a9a-5120-4cc2-a76b-92a516ab6500.open-xchange@email.1und1.de>
 <1478074489.19127.7.camel@embedded.rocks>
 <ac897803-47e5-6b0b-5664-6dc165c56c23@i2se.com>
 <1478285097.26659.2.camel@embedded.rocks>
 <1783642995.185945.5e54a2af-ba2c-4901-93f6-1967dd432939.open-xchange@email.1und1.de>
 <1478299359.26659.5.camel@embedded.rocks>
 <963717394.159124.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <1478347610.353.2.camel@embedded.rocks> <1478349578.3405.5.camel@intel.com>
Message-ID: <CAOMZO5AZDANN_z6-qNgRjZOsBMX6PQv26Mbq8iVtkbrE3GvQ+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Sat, Nov 5, 2016 at 10:39 AM, Koul, Vinod <vinod.koul@intel.com> wrote:
> On Sat, 2016-11-05 at 13:06 +0100, J?rg Krause wrote:
>> @ Vinod
>> In short, I noticed poor performance in the SSP2 (MMC/SD/SDIO)
>> interface on a custom i.MX28 board with a wifi chip attached.
>> Comparing
>> the bandwith with iperf I get >20Mbits/sec on the vendor kernel and
>> <5Mbits/sec on the mainline kernel. I am trying to investigate what
>> the
>> bottleneck is.
>
> is this imx-dma or imx-sdma..

This is drivers/dma/mxs-dma.c, thanks.
