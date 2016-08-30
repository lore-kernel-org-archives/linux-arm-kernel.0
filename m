From: jingoohan1@gmail.com (Jingoo Han)
Date: Tue, 30 Aug 2016 14:15:00 -0400
Subject: [PATCH v2] arm64:pci: fix the IOV device access config space
 valid condition
In-Reply-To: <HE1PR0402MB2748F7A71F8A0073644EE3568BE00@HE1PR0402MB2748.eurprd04.prod.outlook.com>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
 <1472455618-17892-1-git-send-email-po.liu@nxp.com>
 <000a01d202d5$3f86e3a0$be94aae0$@gmail.com>
 <HE1PR0402MB2748F7A71F8A0073644EE3568BE00@HE1PR0402MB2748.eurprd04.prod.outlook.com>
Message-ID: <000401d202ea$6e6d5ef0$4b481cd0$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 30, 2016 11:55 AM, Roy Zang wrote:
> 
> On 08/30/2016 10:43 AM, Jingoo Han wrote:
> > I really don't like to modify host driver stuffs.
> > But, if there is no alternatives, this patch looks good.
> 
> I do not see other good place to fix the bug.

Hi Roy Zang,

I didn't find other good place, too.
At that time, I did IOV test with the similar patch like this.

Best regards,
Jingoo Han

> 
> Roy Zang <roy.zang@nxp.com>
> 
> Roy
