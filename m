From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 30 May 2013 09:39:17 +0200
Subject: [v2, 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to
 am335x-evm
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9C8BCD@DBDE04.ent.ti.com>
References: <ebfab3e9123b3e50b9a9678c1480191addd86d59.1359007746.git.avinashphilip@ti.com>
 <517F5126.5000509@ti.com> <20130508235404.GX32546@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C320D@DBDE04.ent.ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C5629@DBDE04.ent.ti.com>
 <51A6FEA8.5030704@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C8BCD@DBDE04.ent.ti.com>
Message-ID: <51A70225.50300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2013 09:31 AM, Gupta, Pekon wrote:
>> Sorry, I missed that series.
>>
>> I'm applying it right now.
>>
> No issues.. Please pick newer v4 versions of this series.
> Following are rebased, updated and tested on linux-3.10-rc3
> 
> [PATCH v4,0/3] http://www.spinics.net/lists/linux-omap/msg91165.html
> 
> [PATCH v4,1/3] http://www.spinics.net/lists/linux-omap/msg91166.html
> 
> [PATCH v4,2/3] (please skip this one)
> instead pick http://www.spinics.net/lists/linux-omap/msg91161.html
> 
> [PATCH v4,3/3] http://www.spinics.net/lists/linux-omap/msg91167.html

Could you please rebase on for_3.11/dts and repost the whole stuff. It
looks like Tony already pulled the GPMC node, and the two other ones
cannot apply anymore.

Thanks,
Benoit
