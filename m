From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Nov 2012 14:06:22 -0800
Subject: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <509F6CE3.50806@compulab.co.il>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <20121107173343.GF6801@atomide.com> <509B5B84.50605@compulab.co.il>
 <20121108162004.GA6801@atomide.com> <509F6CE3.50806@compulab.co.il>
Message-ID: <20121112220621.GQ6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [121111 01:18]:
> On 11/08/12 18:20, Tony Lindgren wrote:
> > 
> > I guess what I'm after is just to avoid renaming the existing
> > timers in the board-*.c files and only rename the ones that
> > need gp timer only.
> 
> This means: get rid of the 32k to gptimer fall back.
> I've got your point, will cook something shortly.

Thanks that sounds reasonable to me.

Regards,

Tony
