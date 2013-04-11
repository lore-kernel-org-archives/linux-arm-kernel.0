From: rui.zhang@intel.com (Zhang Rui)
Date: Fri, 12 Apr 2013 07:26:01 +0800
Subject: [PATCH 14/30] thermal/exynos: remove unnecessary header inclusions
In-Reply-To: <51660F85.4000105@ti.com>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-15-git-send-email-arnd@arndb.de>
 <51660F85.4000105@ti.com>
Message-ID: <1365722761.2183.7.camel@rzhang1-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-10 at 21:19 -0400, Eduardo Valentin wrote:
> Rui, Arnd,
> 
> As agreed in [1], I will be helping on the thermal maintenance.
> 
> On 10-04-2013 20:04, Arnd Bergmann wrote:
> > In multiplatform configurations, we cannot include headers
> > provided by only the exynos platform. Fortunately a number
> > of drivers that include those headers do not actually need
> > them, so we can just remove the inclusions.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-pm at vger.kernel.org
> > Cc: Zhang Rui <rui.zhang@intel.com>
> 
> This patch looks good to me.
> 
> You can add my:
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
> 
applied to thermal thermal branch.

thanks,
rui
> 
> [1] - http://marc.info/?l=linux-pm&m=136560509922173&w=2
