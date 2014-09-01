From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Sep 2014 18:29:24 +0100
Subject: [RFC PATCH for Juno 2/2] tty: SBSA compatible UART
In-Reply-To: <20140901171856.GL2953@xora-haswell.xora.org.uk>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-3-git-send-email-hanjun.guo@linaro.org>
 <20140901171248.GG608@arm.com>
 <20140901171856.GL2953@xora-haswell.xora.org.uk>
Message-ID: <20140901172924.GJ608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 06:18:56PM +0100, Graeme Gregory wrote:
> On Mon, Sep 01, 2014 at 06:12:48PM +0100, Catalin Marinas wrote:
> > On Mon, Sep 01, 2014 at 04:06:01PM +0100, Hanjun Guo wrote:
> > > From: Graeme Gregory <graeme.gregory@linaro.org>
> > > 
> > > This is a subset of pl011 UART which does not supprt DMA or baud rate
> > > changing.
> > > 
> > > It is specified in the Server Base System Architecture document from
> > > ARM.
> > > 
> > > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > > ---
> > >  drivers/tty/Kconfig    |    6 +
> > >  drivers/tty/Makefile   |    1 +
> > >  drivers/tty/sbsauart.c |  328 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 335 insertions(+)
> > >  create mode 100644 drivers/tty/sbsauart.c
> > 
> > Any overlap with this?
> > 
> > http://www.spinics.net/lists/arm-kernel/msg358084.html
> > 
> I knew that driver was being developed and is why we specifically said
> we did not plan to upstream this in preference for ARMs version.
> 
> I just missed the release of this 2 days ago.

Thanks. Please give feedback to Andre when you had the chance to look at
it.

-- 
Catalin
