From: mturquette@ti.com (Mike Turquette)
Date: Thu, 06 Sep 2012 17:08:19 -0700
Subject: [PATCH 0/1] clk: add DT fixed-factor-clock binding support
In-Reply-To: <5048CC37.6060509@gmail.com>
References: <1346194382-11405-1-git-send-email-gregory.clement@free-electrons.com>
 <5048CC37.6060509@gmail.com>
Message-ID: <20120907000819.20289.87301@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2012-09-06 09:15:51)
> On 08/28/2012 05:53 PM, Gregory CLEMENT wrote:
> > Hi,
> > 
> > During the port of the clock common framework for the armada 370/XP, I
> > need to get "fixed-factor-clock" using the device tree. For this need
> > I add support DT for "fixed-factor-clock" in the same way that the
> > existing support for "fixed-rate-clock". It turned out that finally I
> > didn't need it anymore, but as the code was written and tested, here
> > it is.
> > 
> 
> It looks fine to me, but I'd like to see a user of it.
> 

Agreed.  I'll hold off on merging it until someone else depends on it.

Thanks for submitting this Gregory.

Regards,
Mike

> Rob
