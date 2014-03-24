From: mporter@linaro.org (Matt Porter)
Date: Mon, 24 Mar 2014 15:38:43 -0400
Subject: [PATCH 1/2] ARM: add cpu_is_pj4() to distinguish PJ4 core
In-Reply-To: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
References: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20140324193545.GE24294@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 03:01:58PM +0800, Chao Xie wrote:
> PJ4 is based on V7, but it has some changes. For example, some
> coprocessor settings.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

Retested on bcm28155-ap for the updated series:

Tested-by: Matt Porter <mporter@linaro.org>

-Matt
