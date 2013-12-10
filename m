From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 18:42:16 +0000
Subject: [PATCH v3 08/15] mfd: menelaus: Pass menelaus_chip pointer to
 add/remove irq functions
In-Reply-To: <20131210163249.GF22750@saruman.home>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-8-git-send-email-balbi@ti.com>
 <20131210090021.GQ12675@lee--X1>
 <20131210163249.GF22750@saruman.home>
Message-ID: <20131210184216.GD2390@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Felipe Balbi wrote:

> On Tue, Dec 10, 2013 at 09:00:21AM +0000, Lee Jones wrote:
> > On Mon, 09 Dec 2013, Felipe Balbi wrote:
> > 
> > > Those functions are static and can receive a menelaus_chip pointer very
> > > easily.
> > > 
> > > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  drivers/mfd/menelaus.c | 57 ++++++++++++++++++++++++++------------------------
> > >  1 file changed, 30 insertions(+), 27 deletions(-)
> > 
> > Same here. I think this should be done in one fell swoop.
> 
> then it would become a much, much larger patch which would become a pain
> to review.

If the patch was doing lots of different things then I'd be inclined
to agree, but although large, the changes here are pretty trivial.

I tend to break up patches based on; subsystem, file, device (for
platform/dts adaptions) and functionality. Rather than just because
the 'lines changed' count is large.

Please squash them and I'll review it.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
