From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 May 2017 18:25:06 +0800
Subject: [PATCH] clk: sunxi-ng: explicitly include linux/spinlock.h
In-Reply-To: <20170515102307.28743-1-tklauser@distanz.ch>
References: <20170515102307.28743-1-tklauser@distanz.ch>
Message-ID: <CAGb2v67C9xFYjs_cAuHHhSayjT5KNUCXM5a_3-Wj2BrzmEbmBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 6:23 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> ccu_reset.h and ccu_reset.c use spinlock_t and associated functions but
> rely on implict inclusion of linux/spinlock.h which means that changes
> in other headers could break the build. Thus, add an explicit include.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Chen-Yu Tsai <wens@csie.org>
