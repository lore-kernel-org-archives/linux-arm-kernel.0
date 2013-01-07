From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 7 Jan 2013 09:20:16 +0000
Subject: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
In-Reply-To: <20130104122612.GM4627@opensource.wolfsonmicro.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB3690C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 17:56:12, Mark Brown wrote:
> On Fri, Jan 04, 2013 at 03:24:37PM +0530, Hebbar Gururaja wrote:
> 
> > +		"MIC3L",                "Mic Bias 2V",
> > +		"MIC3R",                "Mic Bias 2V",
> > +		"Mic Bias 2V",          "Mic Jack",
> 
> The CODEC driver biases should be changed over to be supplies, this
> makes the above much more natural - the routing there is a hack for
> older versions of ASoc.  

I will be looking into this now. To speed up the things, do you have any
reference link/implementation which  I can refer to?

I looked at the OMAP implementation but they are following the same (meaning both
DT & non-DT use similar audio map for routing).


> Otherwise this looks fine.

Thanks for the review.

> 


Regards, 
Gururaja
