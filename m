From: davem@davemloft.net (David Miller)
Date: Tue, 04 Nov 2014 17:09:20 -0500 (EST)
Subject: [PATCH v2 0/3] drivers: net: xgene: Fix crash for backward
 compatibility
In-Reply-To: <1415044796-5081-1-git-send-email-isubramanian@apm.com>
References: <1415044796-5081-1-git-send-email-isubramanian@apm.com>
Message-ID: <20141104.170920.1468894786590700012.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon,  3 Nov 2014 11:59:53 -0800

> This patch set fixes the following issues that were reported during regression.
> 
> Patch 1,2 : Adds backward compatibility with the older firmware (<= 1.13.28).
> Patch 3   : Use separate hardware resources (descriptor ring, prefetch buffer)
> 	   that are not shared with the firmware

Series applied, thanks.
