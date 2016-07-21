From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 21 Jul 2016 10:09:55 -0700
Subject: [PATCH v2 1/9] mtd:fsl-quadspi:use the property fields of SPI-NOR
In-Reply-To: <VI1PR0401MB26403FE955617EFEB3DD809294090@VI1PR0401MB2640.eurprd04.prod.outlook.com>
References: <1461307192-866-1-git-send-email-B56489@freescale.com>
 <DB5PR0401MB191200E18A336E0BE5318D1694240@DB5PR0401MB1912.eurprd04.prod.outlook.com>
 <VI1PR0401MB26403FE955617EFEB3DD809294090@VI1PR0401MB2640.eurprd04.prod.outlook.com>
Message-ID: <20160721170955.GA91127@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 05:58:48AM +0000, Yunhui Cui wrote:
> Could you please help to review this patch set.
> This patch set is very importmant for fsl-quadspi driver. 

I didn't want this to be my only comment, but since you're pinging
again...

Your patchset doesn't build on the latest. You need to refresh.

Also, has Han Xu reviewed this?
