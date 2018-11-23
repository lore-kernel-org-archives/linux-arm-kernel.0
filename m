From: davem@davemloft.net (David Miller)
Date: Fri, 23 Nov 2018 11:17:19 -0800 (PST)
Subject: [PATCH v3 0/3] dpaa_eth: add ethtool coalesce control
In-Reply-To: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
References: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <20181123.111719.418226927543456028.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Wed, 21 Nov 2018 13:41:06 +0200

> Add control of the DPAA portal interrupt coalescing settings from
> ethtool.
> 
> changes from v2: read ithresh from HW, set previous values on failure
> changes from v1: added range checking for the QMan APIs

Series applied.
