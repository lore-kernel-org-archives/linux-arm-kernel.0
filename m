From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 Aug 2013 11:50:09 -0400
Subject: [PATCH 3/5] ARM: mach-mvebu: remove redundant DT parsing and
 validation
In-Reply-To: <5203B70F.1050109@free-electrons.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374579164-30255-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <5203B13F.4060009@arm.com> <5203B70F.1050109@free-electrons.com>
Message-ID: <20130808155009.GI8204@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 05:19:43PM +0200, Gregory CLEMENT wrote:
> On 08/08/2013 16:54, Sudeep KarkadaNagesha wrote:
> > On 23/07/13 12:32, Sudeep KarkadaNagesha wrote:
> >> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> >>
> >> arm_dt_init_cpu_maps parses the device tree, validates and sets the
> >> cpu_possible_mask appropriately. It is unnecessary to do another DT
> >> parse to get the number of cpus, use num_possible_cpus instead.
> >>
> > Hi Gregory,
> > 
> > Does this change look fine ?
> 
> Yes it is a nice cleanup.
> 
> and I have just test it on an Armada XP DB board.
> 
> So you can add
> 
> my Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
> 
> > If OK, not sure if you prefer to pick up this or want me to send to
> > arm-soc guys.
> 
> I think it is better if we pick up this patch as it only touch a file
> belonging to mvebu.
> 
> Jason,
> do you agree to pick it up and then push it to in your next (and maybe
> last) pull request?

Yep.

thx,

Jason.
