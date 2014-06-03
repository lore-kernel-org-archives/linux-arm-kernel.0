From: davem@davemloft.net (David Miller)
Date: Mon, 02 Jun 2014 23:39:37 -0700 (PDT)
Subject: [PATCH v4 0/2] add hix5hd2 mac driver
In-Reply-To: <1401774577-16683-1-git-send-email-zhangfei.gao@linaro.org>
References: <1401774577-16683-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140602.233937.182448049174382056.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue,  3 Jun 2014 13:49:35 +0800

> v4:
> Update indent
> Use usleep_range instead of udelay
> 
> v3:
> Remove .ndo_get_stats as mentioned by Tobias
> Add __le32 conversion pointed by Mark
> 
> v2:
> Update binding accoring to Sergei comments
> Update descriptor as Arnd's suggestion

Series applied, thanks.
