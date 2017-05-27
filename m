From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 May 2017 13:25:15 -0300
Subject: [PATCH 2/2] mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.
In-Reply-To: <9a7ab387-a3e5-913a-2204-2b337ba0f8aa@mleia.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482211233.10253607@f408.i.mail.ru>
 <CAM=E1R5=k5NXurdV=6TzE9bPH5M3zyFpUjuJpGd9ECKrdjaj7w@mail.gmail.com>
 <1482300049.831956101@f373.i.mail.ru>
 <CAM=E1R7mBa7PSyshR+VwbeCqqDytkTknNksWQmf3Yk2r0_nHZw@mail.gmail.com>
 <1bec9023-1869-2847-bea6-adebc5af0093@mleia.com>
 <CAOMZO5CifMQGu2dFAm4a5BTUrqdJS77k-n3daBR6qCqtdX_W-Q@mail.gmail.com>
 <9a7ab387-a3e5-913a-2204-2b337ba0f8aa@mleia.com>
Message-ID: <CAOMZO5AoHeB5xK+tAyKGyf1wejM86W9o+vRnZMTfU+bRw4qsMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Wed, Dec 21, 2016 at 11:08 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> Basic support is done, IOMUX driver is developed, practically everything
> but multimedia and USB are tested and working well, SPI driver needs
> some minor special attention mentioned above, hopefully I'll find time
> to submit core imx31.dtsi changes this week.

Do you plan to submit the mx31 pinctrl driver? It would be nice if we
could move mx31 to DT.

Thanks
