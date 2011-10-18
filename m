From: greg@kroah.com (Greg KH)
Date: Tue, 18 Oct 2011 11:13:19 -0700
Subject: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
	<CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
Message-ID: <20111018181319.GA7015@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 11:39:11AM +0800, Barry Song wrote:
> 2011/10/14 Barry Song <Barry.Song@csr.com>:
> > From: Rong Wang <Rong.Wang@csr.com>
> >
> > SiRFprimaII is the latest generation application processor from CSR?s
> > multi-function SoC product family.
> > The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> > 3.0.
> >
> > There are three dedicated UARTs in system. This patch adds basic driver
> > support for them.
> >
> > It has used the newest pinmux subsystem from Linus Walleij.
> 
> Hi Alan, it means this patch doesn't compile until pinmux tree of
> Linus Walleij is merged into mainline.
> Now it is a linux next tree.

So should it go through the pinmux tree?  Or do you want to wait for the
3.3 kernel release to get this merged?

thanks,

greg k-h
