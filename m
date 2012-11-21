From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 11:00:23 +0100
Subject: [PATCH 1/4] pinctrl: mvebu: fix iomem pointer for dove pinctrl
In-Reply-To: <1353317996-20841-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353317996-20841-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkda=wxmHPk_9uUajYqhbcxxK8bjnYfc-VeLGFif0WUd99Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 10:39 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> There has been a change in readl/writel to require registers
> addresses marked as IOMEM(). This patch takes care of this and
> also replaces ORing address offsets with adding them.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
