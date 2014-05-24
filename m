From: davem@davemloft.net (David Miller)
Date: Sat, 24 May 2014 14:03:58 -0400 (EDT)
Subject: [PATCH v2 0/4] ks8851 DT/regulator/gpio updates
In-Reply-To: <1400875040-13269-1-git-send-email-sboyd@codeaurora.org>
References: <1400875040-13269-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140524.140358.1963098926345179335.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 23 May 2014 12:57:16 -0700

> This set of patches properly documents the micrel ks8851 spi ethernet
> controller, converts to devm_regulator_get_optional() to make error
> paths slightly simpler, and finally adds supports for another
> optional regulator and a reset gpio. This allows me to use the ks8851
> on my MSM8960 CDP board.
> 
> Changes since v1:
>  * Dropped vendor prefix patch as that should go through DT tree

Series applied, thanks Stephen!
