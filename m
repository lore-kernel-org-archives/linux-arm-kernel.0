From: davem@davemloft.net (David Miller)
Date: Thu, 22 Oct 2015 07:20:05 -0700 (PDT)
Subject: [PATCH net-next] net: hisilicon: deals with the sub ctrl by syscon
In-Reply-To: <1445421464-238140-1-git-send-email-yankejian@huawei.com>
References: <1445421464-238140-1-git-send-email-yankejian@huawei.com>
Message-ID: <20151022.072005.867458819587525446.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yankejian <yankejian@huawei.com>
Date: Wed, 21 Oct 2015 17:57:44 +0800

>   the global Soc configuration is treated by syscon, and sub ctrl bus is
> Soc bus. it has to be treated by syscon.
> 
> Signed-off-by: yankejian <yankejian@huawei.com>
> Signed-off-by: lisheng <lisheng011@huawei.com>
> Signed-off-by: lipeng <lipeng321@huawei.com>

Applied, thanks.
