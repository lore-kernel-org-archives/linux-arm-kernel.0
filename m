From: davem@davemloft.net (David Miller)
Date: Tue, 06 Jun 2017 15:00:15 -0400 (EDT)
Subject: [PATCH v2 3/4] net: macb: macb.c changed to macb_main.c
In-Reply-To: <20170606183933.GA1205@localhost.localdomain>
References: <1496413439-12900-1-git-send-email-rafalo@cadence.com>
 <1496413661-21452-1-git-send-email-rafalo@cadence.com>
 <20170606183933.GA1205@localhost.localdomain>
Message-ID: <20170606.150015.1247326483451270973.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 6 Jun 2017 20:39:33 +0200

> On Fri, Jun 02, 2017 at 03:27:41PM +0100, Rafal Ozieblo wrote:
>>  drivers/net/ethernet/cadence/macb.c      | 3568 ------------------------------
>>  drivers/net/ethernet/cadence/macb_main.c | 3568 ++++++++++++++++++++++++++++++
> 
> You deleted macb.c, and so ...

Rename macb.c to macb_main.c

>> +macb-y	:= macb_main.o
>>  
>>  obj-$(CONFIG_MACB) += macb.o
> 
> how does this rule make sense any more?

He's adjusting the Makefile so that it build macb_main.c into macb.o
