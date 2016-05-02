From: davem@davemloft.net (David Miller)
Date: Mon, 02 May 2016 16:48:18 -0400 (EDT)
Subject: [PATCH v2 0/3] drivers: net: xgene: fix: Get channel number
 from device binding
In-Reply-To: <1461953415-9741-1-git-send-email-isubramanian@apm.com>
References: <1461953415-9741-1-git-send-email-isubramanian@apm.com>
Message-ID: <20160502.164818.1876590443775185144.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Fri, 29 Apr 2016 11:10:12 -0700

> This patch set adds 'channel' property to get ethernet to CPU channel number,
> thus decoupling the Linux driver from static resource selection.
> 
> v2: Address review comments from v1
> - removed irq reference from Linux driver
> - added 'channel' property to get ethernet to CPU channel number
> 
> v1:
> - Initial version
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

Series applied, thanks.
