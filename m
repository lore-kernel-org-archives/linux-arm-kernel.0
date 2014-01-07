From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Jan 2014 15:07:34 -0800
Subject: [PATCH V5 0/4] DRIVERS: IRQCHIP: Add support for crossbar IP
In-Reply-To: <52C11284.2030500@ti.com>
References: <1386066445-28245-1-git-send-email-r.sricharan@ti.com>
 <52B168A5.4010202@ti.com> <52BBB614.5010707@ti.com>
 <52BC6B16.80507@ti.com> <52BD856E.7010609@ti.com>
 <52C11284.2030500@ti.com>
Message-ID: <20140107230733.GD5074@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [131229 22:30]:
> On Friday 27 December 2013 07:19 PM, Sricharan R wrote:
> > On Thursday 26 December 2013 11:14 PM, Santosh Shilimkar wrote:
> >> On Wednesday 25 December 2013 11:52 PM, Sricharan R wrote:
> >>> On Wednesday 18 December 2013 02:49 PM, Sricharan R wrote:
> >>>> I have addressed all the comments on this series, can this be merged now ?
> >>>>
> >>>   Ping..
> >>>
> >> Thomas has already given his reviewed-by tag so the patches can be
> >> taken via arm-soc tree considering OMAP and GIC changes. Can you
> >> create a branch with all these patches applied and send it
> >> to Tony ?
> >>
> > Ok, i will send out a branch for this.
> > 
>  
>  I have pushed the below branch
> 
> git://github.com/Sricharanti/sricharan.git
> branch: crossbar
> 
> This is on top of Tony's linux-omap master branch

The linux-omap master branch cannot be used as a base as it
contains tons of commit history not in mainline. So I'll
manually applied these patches into omap-for-v3.14/crosbar
branch.

Regards,

Tony
