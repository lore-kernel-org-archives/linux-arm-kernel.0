From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Mar 2012 11:30:59 -0700
Subject: [PATCH 2/9] omap: fix visibility of omap2_mbox_iva_priv
In-Reply-To: <1332522836-29517-3-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20120323183057.GG9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* mathieu.poirier at linaro.org <mathieu.poirier@linaro.org> [120323 10:16]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> map2_mbox_iva_priv is used on multiple omap2 socs but is hidden
> in an outdated #ifdef that is specific to a single soc.

I think this got fixed with 655850ed (ARM: OMAP2: fix mailbox init code).

Tony
