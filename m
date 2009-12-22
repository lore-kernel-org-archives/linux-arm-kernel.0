From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 22 Dec 2009 21:59:26 +0800
Subject: [PATCH 2/2] pxa: remove reduntant gpio setting on mmc slot
In-Reply-To: <771cded00912220429t3555d887v2ab7c13367900c3b@mail.gmail.com>
References: <771cded00912220429t3555d887v2ab7c13367900c3b@mail.gmail.com>
Message-ID: <f17812d70912220559t6724fa67i328c68d9cdc13fe8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 8:29 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 4e76839bc9703447ff2b3500c430a47c5d6a00c1 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 22 Dec 2009 15:11:30 -0500
> Subject: [PATCH] [ARM] pxa: remove reduntant gpio setting on mmc slot
>
> PXA mmc host driver supports card detect, read only and power gpio pin
> setting already. Zylonite platform driver needn't implement this any more.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Applied.
