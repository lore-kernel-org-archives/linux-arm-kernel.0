From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 24 Aug 2013 12:06:25 -0300
Subject: [PATCH v2 4/4] pinctrl: mvebu: Convert to use
 devm_ioremap_resource
In-Reply-To: <1377225242-5854-5-git-send-email-jszhang@marvell.com>
References: <1377225242-5854-1-git-send-email-jszhang@marvell.com>
 <1377225242-5854-5-git-send-email-jszhang@marvell.com>
Message-ID: <20130824150624.GA12907@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On Fri, Aug 23, 2013 at 10:34:02AM +0800, Jisheng Zhang wrote:
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Mmm.. I would prefer to see a better commit log for this patch.
In particular, the current code is buggy (for there's a leak) and
this patch fixes it.
Care to write something meaningful and re-send? (except the patch
Mike already took, I guess).

With that changes you can add:

Reviewed-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>T

for the whole series.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
