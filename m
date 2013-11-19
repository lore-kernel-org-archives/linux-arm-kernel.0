From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 09:39:57 +0100
Subject: [patch] pinctrl: rockchip: missing unlock on error in
 rockchip_set_pull()
In-Reply-To: <20131114082254.GE8150@elgon.mountain>
References: <20131114082254.GE8150@elgon.mountain>
Message-ID: <CACRpkdZxQcqj6WnG+gY_JAO7Du92Cm+EgzFiX=ngaQP90y-MHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 9:22 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:

> We need to unlock here before returning -EINVAL.
>
> Fixes: 6ca5274d1d12 ('pinctrl: rockchip: add rk3188 specifics')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied with Heiko's ACK.

Thanks!
Linus Walleij
