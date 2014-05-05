From: pavel@denx.de (Pavel Machek)
Date: Mon, 5 May 2014 15:00:21 +0200
Subject: [PATCH 1/2] hwinit support for non-TI devices
In-Reply-To: <5367824D.2070406@pengutronix.de>
References: <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120810.GB16461@amd.pavel.ucw.cz>
 <5367824D.2070406@pengutronix.de>
Message-ID: <20140505130021.GD16649@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +	ctrl = readl(priv->raminit_ctrlreg);
> > +	ctrl &= ~DCAN_RAM_INIT_BIT;
> > +	writel(ctrl, priv->raminit_ctrlreg);
> 
> Why don't use use the reg directly? Have you read my previous
> review?

Not really. I did not notice that there are more comments below all
that quoted text. Standby.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
