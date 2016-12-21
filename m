From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Dec 2016 18:28:30 -0200
Subject: [PATCH 2/2] mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.
In-Reply-To: <1bec9023-1869-2847-bea6-adebc5af0093@mleia.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482211233.10253607@f408.i.mail.ru>
 <CAM=E1R5=k5NXurdV=6TzE9bPH5M3zyFpUjuJpGd9ECKrdjaj7w@mail.gmail.com>
 <1482300049.831956101@f373.i.mail.ru>
 <CAM=E1R7mBa7PSyshR+VwbeCqqDytkTknNksWQmf3Yk2r0_nHZw@mail.gmail.com>
 <1bec9023-1869-2847-bea6-adebc5af0093@mleia.com>
Message-ID: <CAOMZO5CifMQGu2dFAm4a5BTUrqdJS77k-n3daBR6qCqtdX_W-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 6:24 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> Correct, I would recommend to postpone adding any extensions to the driver
> platform data, which by the way is found in include/linux/mfd/mc13xxx.h
>
> The extension can be added only when it becomes needed.

Yes, I agree.

> FWIW I ran the v4.9-rc kernel with device trees on i.MX31 Lite board
> with MC13783, and what I can confirm is that in my case the proposed
> change is not needed at all. Thus I'm going to verify shortly that
> the commit does not break the currently correct runtime behaviour on
> my board.

Nice to see imx31 with dt support :-)
