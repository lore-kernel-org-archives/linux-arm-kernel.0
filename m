From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 24 Dec 2016 11:21:20 -0200
Subject: [PATCH 2/2] mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.
In-Reply-To: <CAM=E1R4HarEBjCiGgG2AwnWqdLBGpLKPXAokEbZEdwXRUUa5Fw@mail.gmail.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482211233.10253607@f408.i.mail.ru>
 <CAM=E1R5=k5NXurdV=6TzE9bPH5M3zyFpUjuJpGd9ECKrdjaj7w@mail.gmail.com>
 <1482300049.831956101@f373.i.mail.ru>
 <CAM=E1R7mBa7PSyshR+VwbeCqqDytkTknNksWQmf3Yk2r0_nHZw@mail.gmail.com>
 <1bec9023-1869-2847-bea6-adebc5af0093@mleia.com>
 <CAOMZO5CifMQGu2dFAm4a5BTUrqdJS77k-n3daBR6qCqtdX_W-Q@mail.gmail.com>
 <9a7ab387-a3e5-913a-2204-2b337ba0f8aa@mleia.com>
 <CAM=E1R4HarEBjCiGgG2AwnWqdLBGpLKPXAokEbZEdwXRUUa5Fw@mail.gmail.com>
Message-ID: <CAOMZO5B8fL6MmBViQLqtCtWnX8gSTkFaXJX+9tO-=bihJfFJNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 6:16 PM, Magnus Lilja <lilja.magnus@gmail.com> wrote:

> So, have we reached a conclusion that a solution based on the code
> below is good enough for now? Further device tree development would
> make it possible to support other triggers on i.MX31 boards. And any
> board that already has dt support can override TRIGGER_HIGH since
> irqd_get_trigger_type() will return something else than IRQ_TYPE_NONE.

I would say that you could send a v2 with the only difference being
the commit log explaining which was the commit that caused the
problem, add a Fixes tag and Cc: stable.

Thanks
