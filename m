From: roy.zang@nxp.com (Roy Zang)
Date: Tue, 30 Aug 2016 15:54:43 +0000
Subject: [PATCH v2] arm64:pci: fix the IOV device access config space
 valid condition
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
 <1472455618-17892-1-git-send-email-po.liu@nxp.com>
 <000a01d202d5$3f86e3a0$be94aae0$@gmail.com>
Message-ID: <HE1PR0402MB2748F7A71F8A0073644EE3568BE00@HE1PR0402MB2748.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2016 10:43 AM, Jingoo Han wrote:
> I really don't like to modify host driver stuffs.
> But, if there is no alternatives, this patch looks good.

I do not see other good place to fix the bug.

Roy Zang <roy.zang@nxp.com>

Roy
