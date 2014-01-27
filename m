From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 Jan 2014 09:47:10 -0800
Subject: [PATCH 0/9] ARM: dts: imx: remove the use of pingrp macros
In-Reply-To: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
References: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOesGMgV-UPTujzdnb5FWHM7b5X-_f7qCE7awrF4+snB2Tn+9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Sat, Jan 25, 2014 at 8:43 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Rob,
>
> In order to solve a pinctrl data efficiency problem, we introduced
> pingrp macros [1] in this development cycle as the base of board dts
> support.  The whole imx-dt-3.14 pull request has been held by Olof for
> a few weeks because he wants to get a general approval from DT folks
> on this change.  But unfortunately it appears that you are not fond of
> this change.
>
> I just spent the day to create a patch series against imx-dt-3.14 to
> remove these pingrp macros.  May I get your nod on this quick
> turn-around, so that we do not miss the merge window?
>
> Hi Olof,
>
> I guess we do not have to shut the door for imx-dt-3.14 if you and DT
> folks are happy with this patch series, which is a quite straight
> forward search&replace change?

The merge window is halfway over already, the time for us to pick up
large branches like these are long past.

Please rebase (since this is a partial revert of some of the earlier
patches in your dt branch, I think?), and resend after -rc1 for 3.15
inclusion.


Thanks,

-Olof
