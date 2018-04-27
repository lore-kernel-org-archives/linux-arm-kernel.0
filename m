From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Apr 2018 20:51:19 +0200
Subject: [PATCH 1/2 v4] drm/pl111: Support the Versatile Express
In-Reply-To: <c9d69109-1220-b201-e1bd-255c31c1a214@arm.com>
References: <20180423072017.6690-1-linus.walleij@linaro.org>
 <4255fd6b-caf7-1347-b97b-ab7b229a08ba@arm.com>
 <CACRpkdYpMsGOTPU81cO92DFSrzt659UmD_p5uKehBWnZk-cjnw@mail.gmail.com>
 <c9d69109-1220-b201-e1bd-255c31c1a214@arm.com>
Message-ID: <CACRpkdaQ+9+6OHk7s=vsTF=CesMLyKQmN2O3U3pVUa0RRSnxOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 5:02 PM, Robin Murphy <robin.murphy@arm.com> wrote:

> I dug a little bit and it seems pl111_modeset_init() is deferring because it
> can't find endpoint 0. And given that that's apparently pointing at some
> non-existent panel rather than the DVI encoder as I would (naively) expect,
> I can at least form a self-consistent explanation and give up on the grounds
> that I'm probably missing some important DT changes.

Yeah it does help if I also send the required DT changes :/

Sorry for my absentmindedness, I'll shoot it off right now so you
can test it.

Yours,
Linus Walleij
