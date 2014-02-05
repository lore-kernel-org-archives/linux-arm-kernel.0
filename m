From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 05 Feb 2014 11:48:14 +0100
Subject: [PATCH 09/18] mfd: max14577: Add "muic" suffix to regmap and
 irq_chip
In-Reply-To: <20140203094518.GJ13529@lee--X1>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-10-git-send-email-k.kozlowski@samsung.com>
 <20140203094518.GJ13529@lee--X1>
Message-ID: <1391597294.3726.12.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Cc: Chanwoo, Mark and Dmitry for ACK-s on their subsystems.

Krzysztof Kozlowski

On Mon, 2014-02-03 at 09:45 +0000, Lee Jones wrote:
> > This patch continues the preparation for adding support for max77836
> > device to existing max14577 driver.
> > 
> > Add "muic" suffix to regmap and irq_data fields in maxim_core state
> > container to prepare for max77836 support.
> > This is only a rename-like patch, new code is not added.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/extcon/extcon-max14577.c     |   17 +++++++++--------
> >  drivers/mfd/max14577.c               |   22 +++++++++++-----------
> >  drivers/power/max14577_charger.c     |    8 ++++----
> >  drivers/regulator/max14577.c         |    2 +-
> >  include/linux/mfd/max14577-private.h |    4 ++--
> >  5 files changed, 27 insertions(+), 26 deletions(-)
> 
> Happy to apply this with maintainer Acks.
>   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
