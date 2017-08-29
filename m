From: davem@davemloft.net (David Miller)
Date: Tue, 29 Aug 2017 16:13:32 -0700 (PDT)
Subject: [PATCH] drivers: net: xgene: Correct probe sequence handling
In-Reply-To: <1504046592-24779-1-git-send-email-isubramanian@apm.com>
References: <1504046592-24779-1-git-send-email-isubramanian@apm.com>
Message-ID: <20170829.161332.1279744093983010191.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Tue, 29 Aug 2017 15:43:12 -0700

> From: Quan Nguyen <qnguyen@apm.com>
> 
> The phy is connected at early stage of probe but not properly
> disconnected if error occurs.  This patch fixes the issue.
> 
> Also changing the return type of xgene_enet_check_phy_handle(),
> since this function always returns success.
> 
> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

Applied, thank you.
