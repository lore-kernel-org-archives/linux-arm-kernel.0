From: davem@davemloft.net (David Miller)
Date: Thu, 24 Jun 2010 22:05:48 -0700 (PDT)
Subject: [PATCH 1/2] net/fec: clean suspend/resume
In-Reply-To: <1276853351-20790-1-git-send-email-eric@eukrea.com>
References: <1276853351-20790-1-git-send-email-eric@eukrea.com>
Message-ID: <20100624.220548.02285361.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric B?nard <eric@eukrea.com>
Date: Fri, 18 Jun 2010 11:29:10 +0200

> Commit 59d4289b83b11379d867e2f7146904b19cc96404 converted fec to dev_pm_ops but
> didn't update the suspend/resume functions thus leading to the following warning :
> "initialization from incompatible pointer type" when CONFIG_PM is set.
> 
> This patch also fixe a few indentation and style around CONFIG_PM area.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>

So, where's patch 2/2?
