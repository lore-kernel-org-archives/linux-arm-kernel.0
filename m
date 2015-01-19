From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 Jan 2015 08:16:40 +0000
Subject: [PATCH 01/12] mfd: syscon: Add atmel-matrix registers definition
In-Reply-To: <20150118141136.5f871014@bbrezillon>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421252524-24452-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20150118125259.GW3574@x1> <20150118141136.5f871014@bbrezillon>
Message-ID: <20150119081640.GE21886@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 Jan 2015, Boris Brezillon wrote:

> Hi Lee,
> 
> On Sun, 18 Jan 2015 12:52:59 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Wed, 14 Jan 2015, Alexandre Belloni wrote:
> > 
> > > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > 
> > > AT91 SoCs have a memory range reserved for internal bus configuration.
> > > Expose those registers so that drivers can make use of the matrix syscon
> > > declared in at91 DTs.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  include/linux/mfd/syscon/atmel-matrix.h | 117 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 117 insertions(+)
> > >  create mode 100644 include/linux/mfd/syscon/atmel-matrix.h
> > 
> > Applied, thanks.
> 
> Actually Nicolas took all the patches in his tree and already sent a PR
> to the arm-soc maintainers [1].
> 
> [1]https://lkml.org/lkml/2015/1/15/542

Very well.  All unapplied.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
