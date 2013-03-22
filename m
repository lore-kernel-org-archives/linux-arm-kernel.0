From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 22 Mar 2013 16:50:28 +0530
Subject: [PATCH v3 02/11] clk: davinci - add PSC clock driver
In-Reply-To: <50B6101C.30502@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-3-git-send-email-m-karicheri2@ti.com>
 <50950908.1060302@ti.com> <5097D6FC.7040202@ti.com>
 <20121110022254.18014.31873@nucleus> <50B4D6B1.3000903@ti.com>
 <20121127172900.21126.89528@nucleus> <50B6101C.30502@ti.com>
Message-ID: <514C3E7C.3000705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On 11/28/2012 6:52 PM, Sekhar Nori wrote:
> On 11/27/2012 10:59 PM, Mike Turquette wrote:

>> Also have you looked into regmap?  Since you are defining your own clock
>> type that might be something nice for you.
> 
> No, haven't looked at regmap yet. Will look at that.

I could get to this only now. regmap needs a valid struct device. We
aren't modelling psc clocks as device so regmap cannot be used here.

Thanks,
Sekhar
