From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 26 Aug 2013 17:59:25 +0800
Subject: [PATCH v2 4/4] pinctrl: mvebu: Convert to use
 devm_ioremap_resource
In-Reply-To: <20130824150624.GA12907@localhost>
References: <1377225242-5854-1-git-send-email-jszhang@marvell.com>
 <1377225242-5854-5-git-send-email-jszhang@marvell.com>
 <20130824150624.GA12907@localhost>
Message-ID: <20130826175925.5774a277@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Sat, 24 Aug 2013 08:06:25 -0700
Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:

> Hi Jisheng,
> 
> On Fri, Aug 23, 2013 at 10:34:02AM +0800, Jisheng Zhang wrote:
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> 
> Mmm.. I would prefer to see a better commit log for this patch.
> In particular, the current code is buggy (for there's a leak) and
> this patch fixes it.
> Care to write something meaningful and re-send? (except the patch

Done. Could you please review again?

> Mike already took, I guess).
> 
> With that changes you can add:
> 
> Reviewed-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>T
Thank you for your help
> 
> for the whole series.

Best Regards,
Jisheng
