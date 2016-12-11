From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Sun, 11 Dec 2016 14:21:35 +0100
Subject: i.MX31 3DS board not booting after commit 1c2f87c22... ARM:
 8025/1: Get rid of meminfo
In-Reply-To: <CAOMZO5DYwAHdRqqYM-7dKtRJhuV9oGVWYFWmD0JTZR+WFr-XXA@mail.gmail.com>
References: <27bbaa4c-7c8d-cf76-c98f-e8edc89367db@gmail.com>
 <CAOMZO5ChFGrOfgnmaCxw=KwB7ZSp=ZOsmKb_v12_ti48U1NwgA@mail.gmail.com>
 <CAM=E1R7yT_TkzMNVHv3ZYud0w+A7t2x+MKU76ViKC7EVuT1+kg@mail.gmail.com>
 <CAOMZO5DYwAHdRqqYM-7dKtRJhuV9oGVWYFWmD0JTZR+WFr-XXA@mail.gmail.com>
Message-ID: <CAM=E1R5r2F9A61aL_aNicAEoWxQwS+YCmHYpmc+FuSLjgS8Z1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 11 December 2016 at 13:59, Fabio Estevam <festevam@gmail.com> wrote:
> Thinking more about it we see that commit c93cc61475ebbe6 ("[media]
> staging/media: remove deprecated mx3 driver") only appeared in 4.8, so
> it is OK to remove mx31_3ds_reserve() now, but it will not fix the
> kernel boot in the previous kernels.
>
> Commit 1c2f87c22 ("ARM: 8025/1: Get rid of meminfo") is from kernel 3.16 though.
>
> So it seems we need a proper fix for kernels 3.16-4.8.

Yes, indeed. There are a couple long term stable kernels in that range
that needs to be fixed (and also might need other fixes as well to
boot mx31_3ds).

Regards, Magnus
