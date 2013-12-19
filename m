From: gsi@denx.de (Gerhard Sittig)
Date: Thu, 19 Dec 2013 22:15:33 +0100
Subject: [PATCH] clk: remove CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <1387431800-10092-1-git-send-email-mturquette@linaro.org>
References: <1387431800-10092-1-git-send-email-mturquette@linaro.org>
Message-ID: <20131219211533.GT8064@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 21:43 -0800, Mike Turquette wrote:
> 
> Populate ${DEBUGS_MOUNT_POINT}/clk if CONFIG_DEBUG_FS is set. This
> eliminates the extra (annoying) step of enabling the config option
> manually.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>

Yes, please!  The debugfs information is just too useful to hide
behind another option that requires manual enabling. :)


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
