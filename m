From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 19:02:14 +0900
Subject: S5PC100 planning
In-Reply-To: <20100513042545.GT6684@trinity.fluff.org>
References: <20100513042545.GT6684@trinity.fluff.org>
Message-ID: <006901caf283$60709930$2151cb90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> 
> I would like to get an idea of what each group involvedi n the
> current S5PC100 changes is planning to allow the organisation of
> what is going on.
> 
> Firstly, I think Kukjin's clock changes are the first to be
> applied, followed by looking at what support exists (or is being
> submitted) in plat-s5p which could be used for s5pc100.
> 
> Then, let's move out what is left of plat-s5pc1xx into mach-s5pc100
> and get rid of it (although the final removal may have to be left
> until the next merge window, due to time constraints).
> 
> I would like to see whatever changes done grouped into sections,
> such as clock, machine, core, gpio.

I will re-submit S5PC100 clock patch which can be merged to Ben's latest tree
without any compile error.

Marek, can you re-make your patches based on it?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
