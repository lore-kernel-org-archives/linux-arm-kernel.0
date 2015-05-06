From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 May 2015 11:44:54 -0400 (EDT)
Subject: [PATCH 0/5] Second round of MCPM refactoring
In-Reply-To: <5549F4E9.9030303@hisilicon.com>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
 <5549F4E9.9030303@hisilicon.com>
Message-ID: <alpine.LFD.2.11.1505061143190.7750@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 May 2015, Wei Xu wrote:

> 
> 
> On 5/1/2015 5:06 PM, Nicolas Pitre wrote:
> > This is the sequel to the first episode that started here:
> > 
> > 	http://article.gmane.org/gmane.linux.ports.arm.kernel/401353
> > 
> > Now that most of the first set has been merged upstream, here's the last
> > set to complete the cleanup. This mainly includes the removal of the
> > backward compatibility support plus some cosmetic changes.
> > 
> > The hisi04 backend, though, is instead converted to raw SMP operations
> > as it currently doesn't benefit from MCPM at all and doesn't fit well
> > with the new backend structure.
> 
> Tested by: Wei Xu <xuwei5@hisilicon.com>
> 
> Built and booted all the 16 cores on D01 board based on v4.1-rc2.
> And confirmed CPU hotplug works well on D01 board.

Thanks for testing.


Nicolas
