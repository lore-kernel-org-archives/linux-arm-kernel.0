From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 25 Jun 2012 10:55:51 +0530
Subject: [PATCH 07/11] w1: omap_hdq: add clk_prepare and clk_unprepare
In-Reply-To: <alpine.DEB.2.00.1206221234500.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-8-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206221234500.10198@utopia.booyaka.com>
Message-ID: <4FE7F65F.2080002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 June 2012 12:05 AM, Paul Walmsley wrote:
> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> and clk_unprepare() for the hdq clocks.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: Evgeniy Polyakov<zbr@ioremap.net>
>
> This one should not be needed soon:
>
> http://marc.info/?l=linux-omap&m=134037453807275&w=2

Ok, thanks, will drop this one then.

>
> - Paul
