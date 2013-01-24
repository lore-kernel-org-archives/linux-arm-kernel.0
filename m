From: davem@davemloft.net (David Miller)
Date: Thu, 24 Jan 2013 18:18:00 -0500 (EST)
Subject: [PATCH 2/2 net-next] doc: dt: fsl: fec: add napi optional
 properties
In-Reply-To: <1359011219-8343-1-git-send-email-Frank.Li@freescale.com>
References: <1359011219-8343-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130124.181800.580308569081621879.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Thu, 24 Jan 2013 15:06:59 +0800

> Signed-off-by: Frank Li <Frank.Li@freescale.com>

For the thousandth time, you should not make NAPI run time
selectable, this is non-negotable.
