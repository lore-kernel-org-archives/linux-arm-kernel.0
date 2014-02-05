From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 05 Feb 2014 11:45:58 +0100
Subject: [PATCH 07/18] mfd: max14577: Rename and add MAX14577 symbols to
 prepare for max77836
In-Reply-To: <20140203093809.GH13529@lee--X1>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-8-git-send-email-k.kozlowski@samsung.com>
 <20140203093809.GH13529@lee--X1>
Message-ID: <1391597158.3726.10.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for ACK.

Dear Chanwoo, Mark and Dmitry, can you ACK this patch and also 8/18 and
9/18:
http://thread.gmane.org/gmane.linux.kernel/1636654/focus=1636674
http://thread.gmane.org/gmane.linux.kernel/1636654/focus=1636674
?

Best regards,
Krzysztof

On Mon, 2014-02-03 at 09:38 +0000, Lee Jones wrote:
> > This patch prepares for adding support for max77836 device to existing
> > max14577 driver:
> > 1. Renames most of symbols and defines prefixed with MAX14577 to MAXIM.
> > 2. Adds prefixes (MAXIM or MAX14577) to defines without any MAX* prefix.
> > 
> > This is only a rename-like patch, new code is not added.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/extcon/extcon-max14577.c     |  105 ++++-----
> >  drivers/mfd/max14577.c               |   51 ++---
> >  drivers/power/max14577_charger.c     |   81 +++----
> >  drivers/regulator/max14577.c         |   44 ++--
> >  include/linux/mfd/max14577-private.h |  399 ++++++++++++++++------------------
> >  include/linux/mfd/max14577.h         |    2 +-
> >  6 files changed, 333 insertions(+), 349 deletions(-)
> 
> I think the name changes instil some clarity here.
> 
> I still need the other Acks before applying the patch though.
> 
> For now you can have my:
>   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
