From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 25 Jun 2012 10:59:33 +0530
Subject: [PATCH 08/11] crypto: omap: add clk_prepare and clk_unprepare
In-Reply-To: <alpine.DEB.2.00.1206221257480.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-9-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206221257480.10198@utopia.booyaka.com>
Message-ID: <4FE7F73D.6090402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 June 2012 12:28 AM, Paul Walmsley wrote:
> Hi
>
> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> and clk_unprepare() for the omap crypto clocks.
>
> These drivers should be converted to use runtime PM instead, since that
> needs to be done anyway.

So if CCF conversion patches get in before these get converted to
runtime PM, do we break them? or should CCF conversion for OMAP
wait till all remaining drivers get converted to runtime PM?

>
>
> - Paul
