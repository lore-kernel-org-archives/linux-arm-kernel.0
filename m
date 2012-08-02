From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 2 Aug 2012 13:58:07 +0530
Subject: How to debug hard lockup issue
In-Reply-To: <CAF1ivSY=HsqrRypru55cYMBoyY75umkwrjbz5U0F85nL5mh3tw@mail.gmail.com>
References: <CAF1ivSY=HsqrRypru55cYMBoyY75umkwrjbz5U0F85nL5mh3tw@mail.gmail.com>
Message-ID: <CAJe_ZheUy_sFx-0M2Y36NAyOf3fPYM86pneY9vg03fvAE2KKFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 August 2012 08:33, Lin Ming <minggr@gmail.com> wrote:
> Hi list,
>
> I encountered a hard lockup on a armv5 board with 2.6.32 kernel.
> There is no any message output since it is hard lockup.
>
> I tried watchdog, but watchdog can only reset the board. I still can't
> get any info.
>
Maybe take hint from http://www.denx.de/wiki/DULG/LinuxPostMortemAnalysis
