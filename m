From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Feb 2013 10:33:53 +0100
Subject: [PATCH RESEND] ARM: sched: correct update_sched_clock()
In-Reply-To: <1360128076-8555-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1360128076-8555-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <CACRpkdbwoExxKbbvBKpt_Wh9KsgCXQW566N-0BaeL3oGY8pvLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 6, 2013 at 6:21 AM, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:

> If we want load epoch_cyc and epoch_ns atomically,
> we should update epoch_cyc_copy first of all.
> This notify reader that updating is in progress.

If you think the patch is finished, put it into Russell's patch tracker:
http://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
