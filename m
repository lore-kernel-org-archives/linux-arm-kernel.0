From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Aug 2018 14:03:14 +0200
Subject: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
In-Reply-To: <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Aleksey Makarov <amakarov@marvell.com>
>
> This patch adds mailbox support infrastructure APIs.
> Each RVU device has a dedicated 64KB mailbox region
> shared with it's peer for communication. RVU AF has
> a separate mailbox region shared with each of RVU PFs
> and a RVU PF has a separate region shared with each of
> it's VF.
>
> These set of APIs are used by this driver (RVU AF) and
> other RVU PF/VF drivers eg netdev, crypto e.t.c.
>
> Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>

Why does this driver not use the drivers/mailbox/ infrastructure?

       Arnd
