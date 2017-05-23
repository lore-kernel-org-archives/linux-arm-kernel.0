From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 May 2017 09:41:15 +0200
Subject: [PATCH V2 0/5] pinctrl: imx: add generic pin config and imx7ulp
 support
In-Reply-To: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdY2--+JCaPA0zBGrF66DwgOPd6m4=QvCgkO50x35TCzzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 9:05 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> This patch series intends to add the generic pin config support for imx
> platforms.

I applied patches 1,2,3 as you've seen, so please rebase on my "devel"
branch in pin control and only resend the things we are still discussing.

I see there are some other patches flying for imx pin control and GPIO,
if the patches are dependent on each other consider putting it all into
one series. If they are not dependent, then don't.

Yours,
Linus Walleij
