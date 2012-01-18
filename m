From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 18 Jan 2012 20:16:26 +0000
Subject: [PATCH v2 1/3] ARM: davinci: convert to common sched_clock()
 implementation
In-Reply-To: <4F171486.80105@arm.com>
References: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
 <1326903292-15794-2-git-send-email-marc.zyngier@arm.com>
 <DF0F476B391FA8409C78302C7BA518B631794A9F@DBDE01.ent.ti.com>
 <4F171486.80105@arm.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B631794B1E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Jan 19, 2012 at 00:20:46, Marc Zyngier wrote:
> On 18/01/12 18:36, Nori, Sekhar wrote:

> > 
> > I did not like the fact that the asm/ and mach/ headers
> > are intermixed in this file so I created a patch to
> > fix that while I was doing the common sched_clock() conversion.
> > 
> > http://www.spinics.net/lists/arm-kernel/msg153506.html
> > 
> > Can you please rebase your patch on that?
> 
> Sure. I can probably merge that patch altogether in mine if you want.

No, please keep it separate since its not really related to
common sched_clock() conversion.

> 
> > If you are planning to take this from outside of DaVinci tree,
> > feel free to add my:
> > 
> > Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> Thanks. Ideally, I'd like all 3 patches to be kept together, otherwise
> we may end up with patch 3 being applied before patch 1, breaking your
> platform.

No problem, thanks!

Regards,
Sekhar
