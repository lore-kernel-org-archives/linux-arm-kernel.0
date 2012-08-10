From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 10 Aug 2012 22:29:58 +0800
Subject: [PATCH] ARM: mmp: fix potential NULL dereference
In-Reply-To: <1344416528-3586-1-git-send-email-yliu.null@gmail.com>
References: <1344416528-3586-1-git-send-email-yliu.null@gmail.com>
Message-ID: <CAN1soZxkvHOTXb0wfvRmi4DDasD=r9vfoj5uA0CVhAQt2jUkTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 5:02 PM, Yuanhan Liu <yliu.null@gmail.com> wrote:
> Fix the wrong logic: we should use || instead of &&
>
> Cc: Leo Yan <leoy@marvell.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Signed-off-by: Yuanhan Liu <yliu.null@gmail.com>
> ---
>  arch/arm/mach-mmp/sram.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
Applied.

Thanks
Haojian
