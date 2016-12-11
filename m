From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 Dec 2016 10:59:08 -0200
Subject: i.MX31 3DS board not booting after commit 1c2f87c22... ARM:
 8025/1: Get rid of meminfo
In-Reply-To: <CAM=E1R7yT_TkzMNVHv3ZYud0w+A7t2x+MKU76ViKC7EVuT1+kg@mail.gmail.com>
References: <27bbaa4c-7c8d-cf76-c98f-e8edc89367db@gmail.com>
 <CAOMZO5ChFGrOfgnmaCxw=KwB7ZSp=ZOsmKb_v12_ti48U1NwgA@mail.gmail.com>
 <CAM=E1R7yT_TkzMNVHv3ZYud0w+A7t2x+MKU76ViKC7EVuT1+kg@mail.gmail.com>
Message-ID: <CAOMZO5DYwAHdRqqYM-7dKtRJhuV9oGVWYFWmD0JTZR+WFr-XXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Sun, Dec 11, 2016 at 10:51 AM, Magnus Lilja <lilja.magnus@gmail.com> wrote:

> Thanks for the info! Will send a patch later!

Thinking more about it we see that commit c93cc61475ebbe6 ("[media]
staging/media: remove deprecated mx3 driver") only appeared in 4.8, so
it is OK to remove mx31_3ds_reserve() now, but it will not fix the
kernel boot in the previous kernels.

Commit 1c2f87c22 ("ARM: 8025/1: Get rid of meminfo") is from kernel 3.16 though.

So it seems we need a proper fix for kernels 3.16-4.8.

Regards,

Fabio Estevam
