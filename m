From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 14:12:10 -0800
Subject: [PATCH v3 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
In-Reply-To: <20130128115339.GD7754@e106331-lin.cambridge.arm.com>
References: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1359116591-32730-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130125155633.GC16795@e106331-lin.cambridge.arm.com>
 <CALF0-+X2qsF5OETerRSVsJbjkC-JdVXsZhyw1sxQYR+PWX6LHA@mail.gmail.com>
 <20130128115339.GD7754@e106331-lin.cambridge.arm.com>
Message-ID: <20130201221209.GA22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Rutland <mark.rutland@arm.com> [130128 03:57]:
> 
> So if I've understood correctly, the first address cell is the CS, and the
> second the offset within this (as the comment in the onenand at 0 node hints)?
> 
> If so, the code now makes sense to me :)

Sounds like further checking can be added as needed, so applying this
series into omap-for-v3.9/gpmc.

Regards,

Tony
