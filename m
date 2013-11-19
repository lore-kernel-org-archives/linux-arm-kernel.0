From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 08:56:57 +0100
Subject: [patch] pinctrl: rockchip: testing the wrong variable
In-Reply-To: <20131108100138.GO27977@elgon.mountain>
References: <20131108100138.GO27977@elgon.mountain>
Message-ID: <CACRpkdauBBn2A_byet6VrYo3Wok=Rf1MjJqE8H9G4BJXqgTrpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 11:01 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:

> There is a copy and paste bug so we test "info->reg_base" instead of
> "info->reg_pull".
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied for fixes with Heiko's ACK.

Yours,
Linus Walleij
