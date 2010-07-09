From: pieterg@gmx.com (pieterg)
Date: Fri, 9 Jul 2010 10:31:43 +0200
Subject: [PATCH 1/5] cpufreq-pxa3xx: use HSIO 312MHz on the pxa310
In-Reply-To: <AANLkTikbSZ47S4xmswCzj7O665t915EMLVYcbZLR4FUS@mail.gmail.com>
References: <201007081904.01464.pieterg@gmx.com>
	<AANLkTikbSZ47S4xmswCzj7O665t915EMLVYcbZLR4FUS@mail.gmail.com>
Message-ID: <201007091031.44681.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010 10:02:16 Eric Miao wrote:
> What's wrong with 208MHz HSS on PXA310?

I haven't done any benchmarking, but Marvell found it worth to introduce 
312MHz for the pxa310. (I assume it might have something to do with the 
video accelerator, which is unique to the pxa310).

And to me it makes sense to use the highest supported speeds in the top 
cpufreq entry.

Rgds, Pieter
