From: roy.zang@nxp.com (Roy Zang)
Date: Tue, 30 Aug 2016 16:32:33 +0000
Subject: [PATCH v2] arm64:pci: fix the IOV device access config space
 valid condition
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
 <1472455618-17892-1-git-send-email-po.liu@nxp.com>
 <000a01d202d5$3f86e3a0$be94aae0$@gmail.com>
 <HE1PR0402MB2748F7A71F8A0073644EE3568BE00@HE1PR0402MB2748.eurprd04.prod.outlook.com>
Message-ID: <HE1PR0402MB2748D18B3A6AD35B0EA2E4518BE00@HE1PR0402MB2748.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Roy Zang <roy.zang@nxp.com>
Roy
On 08/30/2016 10:54 AM, Roy Zang wrote:
> On 08/30/2016 10:43 AM, Jingoo Han wrote:
>> I really don't like to modify host driver stuffs.
>> But, if there is no alternatives, this patch looks good.
> I do not see other good place to fix the bug.
>
> Roy Zang <roy.zang@nxp.com>
>
> Roy
>
>
