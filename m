From: davem@davemloft.net (David Miller)
Date: Tue, 07 Mar 2017 14:02:06 -0800 (PST)
Subject: [PATCH v3 net-next 2/6] drivers: net: xgene-v2: Add mac
 configuration
In-Reply-To: <1488589773-28055-3-git-send-email-isubramanian@apm.com>
References: <1488589773-28055-1-git-send-email-isubramanian@apm.com>
 <1488589773-28055-3-git-send-email-isubramanian@apm.com>
Message-ID: <20170307.140206.2169938744916149211.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Fri,  3 Mar 2017 17:09:28 -0800

> +void xge_mac_set_station_addr(struct xge_pdata *pdata)
> +{
> +	u32 addr0, addr1;
> +	u8 *dev_addr = pdata->ndev->dev_addr;

Please order local variable declarations from longest to shortest line.
