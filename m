From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Sep 2017 13:09:54 -0300
Subject: dtc: imx6 warnings on unit address format errors
In-Reply-To: <22d62057-c7a0-04d8-3c80-aefb9cbef1b8@gmx.de>
References: <22d62057-c7a0-04d8-3c80-aefb9cbef1b8@gmx.de>
Message-ID: <CAOMZO5D-Fd4w1hJ4GuDXYncqqD2WsDvkRTJzWB2ZVvDWg32gsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 10, 2017 at 1:06 PM, Enrico Weigelt, metux IT consult
<metux@gmx.de> wrote:
> Hi folks,
>
>
> I'm getting lots of warnings from dtc about unit address format errors:
>
> For example in imx6q.dtsi:
>
>      ocram: sram at 00900000 {
>
> The node name's address part has leading zeros which dtc doesn't like.
> It doesn't seem to have a big influence (yet ?), but I'd guess this
> warning is there for a reason.
>
> Should we fix this ?

Yes, feel free to submit a patch that fixes these warnings for all
imx6 dts/dtsi files.

Thanks
