From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 14:48:57 -0400
Subject: [PATCH] irqchip: brcmstb-l2: Level-2 interrupts are edge sensitive
In-Reply-To: <CAGVrzcbpS0tJtkH5vkGRSteV5NU2CzNNkQ43_26XySFqJMAK5A@mail.gmail.com>
References: <1402337102-19428-1-git-send-email-f.fainelli@gmail.com>
 <CAGVrzcZmakEpNW=vGtsb+OmzU_J4hJNoM1sUAoYNsaju_YzGwQ@mail.gmail.com>
 <CAGVrzcbpS0tJtkH5vkGRSteV5NU2CzNNkQ43_26XySFqJMAK5A@mail.gmail.com>
Message-ID: <20140620184857.GB21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 11:26:33AM -0700, Florian Fainelli wrote:
> 2014-06-12 12:13 GMT-07:00 Florian Fainelli <f.fainelli@gmail.com>:
> > 2014-06-09 11:05 GMT-07:00 Florian Fainelli <f.fainelli@gmail.com>:
> >> The driver was configuring the interrupt handler for the Level-2
> >> interrupts to be "level" triggered while they are in fact "edge"
> >> triggered. Fix this by using the correct handler.
> >>
> >> Reported-by: Brian Norris <computersforpeace@gmail.com>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >
> > Jason, Thomas, this driver just got merged into 3.16-rc0, can you
> > carry this fix such that it gets into a future 3.16-rc? Thanks!
> 
> Ping! I want to make sure this gets into a next 3.16-rc pull request.
> Andrew, can you take that one if neither Thomas nor Andrew respond in
> a timely manner?
> 
> Thanks!

relax.  ;-)  I'm doing at least fixes today.

thx,

Jason.
