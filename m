From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Nov 2018 22:32:59 -0200
Subject: [PATCH RESEND V3 1/2] pinctrl: fsl: add scu based pinctrl support
In-Reply-To: <7hin0zgp84.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
References: <1540908354-26809-1-git-send-email-aisheng.dong@nxp.com>
 <1540908354-26809-2-git-send-email-aisheng.dong@nxp.com>
 <7hin0zgp84.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
Message-ID: <CAOMZO5DU6ATmJkXrDd7XJ2_xwjWOa+o1LOdCb_Y0DDdLJAB1nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Nov 14, 2018 at 10:26 PM Kevin Hilman <khilman@baylibre.com> wrote:

> kernelCI found boot failure caused by this patch.
>
> imx6 started failing in kernelCI in next-20181114 on several wand
> boards[1].  There was no kernel output, after uboot started the kernel.
>
> Using the imx6q-wandboard, I bisected it down to this commit.
>
> I verified that reverting this commit on top of next-20181114 fixes the
> problem.

Thanks for the report.

Dong has sent a fix for this issue:
https://www.spinics.net/lists/arm-kernel/msg686738.html
