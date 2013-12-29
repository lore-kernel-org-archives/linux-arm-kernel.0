From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 29 Dec 2013 11:49:10 -0800
Subject: [PATCH] clk: remove CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <20131219211533.GT8064@book.gsilab.sittig.org>
References: <1387431800-10092-1-git-send-email-mturquette@linaro.org>
 <20131219211533.GT8064@book.gsilab.sittig.org>
Message-ID: <20131229194910.21400.59921@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gerhard Sittig (2013-12-19 13:15:33)
> On Wed, Dec 18, 2013 at 21:43 -0800, Mike Turquette wrote:
> > 
> > Populate ${DEBUGS_MOUNT_POINT}/clk if CONFIG_DEBUG_FS is set. This
> > eliminates the extra (annoying) step of enabling the config option
> > manually.
> > 
> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> 
> Yes, please!  The debugfs information is just too useful to hide
> behind another option that requires manual enabling. :)

Applied to clk-next.

Regards,
Mike

> 
> 
> virtually yours
> Gerhard Sittig
> -- 
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
