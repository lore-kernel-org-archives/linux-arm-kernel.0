From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Apr 2012 19:48:43 +0200
Subject: [PATCH] ARM: ux500: Fix build error caused by recent variable
 name change
In-Reply-To: <1335541015-10155-1-git-send-email-lee.jones@linaro.org>
References: <1335541015-10155-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaRdn+q2ODUir6dE8btB8+RTkCYsN0W-Zsj7mkRDNrHQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 5:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> error: ?u8500_soc_node? undeclared (first use in this function)
>
> Was recently changed to 'u8500_local_bus_nodes'.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

IIRC I already fixed this up when applying the patch renaming the node.

Can you check the ux500-core branch on my linux-stericsson tree?

Thanks,
Linus Walleij
