From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 16:20:01 +0100
Subject: [PATCH 15/16] irqchip: vic: mark vic_of_init() as static
In-Reply-To: <50ACEE4F.3030409@gmail.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-16-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdazuvjXuuNP9TrsYsPQWMc=VV_-nu0oNWFPs+GzLmmw2g@mail.gmail.com>
 <20121121135357.5c963404@skate>
 <CACRpkdYU+tt=_xqVjoBnca-V8psRmZhU+UWUm-6i777vP5BChA@mail.gmail.com>
 <20121121154641.718c7b69@skate> <50ACEE4F.3030409@gmail.com>
Message-ID: <20121121162001.1889e9bf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Wed, 21 Nov 2012 09:07:59 -0600, Rob Herring wrote:

> > Yes. I personally haven't yet thought of this part of the problem, but
> > I think Rob has a plan, and if not, we can certainly think of one
> > without too much problems.
> 
> While we can trim down the headers, I don't think we will get rid of
> them in all cases. My only plan was everything gets converted to DT.
> Then we can remove gic_init, gic_cascade_irq, and vic_init.

Sounds like a good plan :-)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
