From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 22 Sep 2016 13:22:46 +0530
Subject: [PATCH v14 4/4] CMDQ: save more energy in idle
In-Reply-To: <1473039885-24009-5-git-send-email-hs.liao@mediatek.com>
References: <1473039885-24009-1-git-send-email-hs.liao@mediatek.com>
 <1473039885-24009-5-git-send-email-hs.liao@mediatek.com>
Message-ID: <CABb+yY1YqyReK5bii6n5a_rJ6fgpPi=aC3sfKJdomvM5+NG9FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2016 at 7:14 AM, HS Liao <hs.liao@mediatek.com> wrote:
> Use clk_disable_unprepare instead of clk_disable to save more energy
> when CMDQ is idle.
>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq.c | 54 +++++++++++++++++++++++++++++++++++++++-------

The driver is introduced by second patch of the set, so it makes sense
to merge this patch into patch 2/4.
