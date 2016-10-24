From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Oct 2016 22:32:31 +1100
Subject: [PATCH] kernel: irq: fix build failure
In-Reply-To: <20161024102215.GN14477@dell>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
 <57FBBA0B.9070500@gmail.com>
 <alpine.DEB.2.20.1610201454410.5073@nanos>
 <20161021120020.52b3fa35@canb.auug.org.au>
 <alpine.DEB.2.20.1610211006370.4797@nanos>
 <20161024102215.GN14477@dell>
Message-ID: <20161024223231.5cdbb2ac@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, 24 Oct 2016 11:22:15 +0100 Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 21 Oct 2016, Thomas Gleixner wrote:
> 
> > On Fri, 21 Oct 2016, Stephen Rothwell wrote:  
> > > On Thu, 20 Oct 2016 14:55:45 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:  
> > > > I know. This is under discussion with the driver folks as we are not going
> > > > to blindly export stuff just because someone slapped a irq_set_parent()
> > > > into the code w/o knowing why.  
> > > 
> > > Do we have any idea if a resolution is close.  This was first reported
> > > in linux-next in September 14/15.  :-(  
> > 
> > Grr. Yes. As much as I hate it, I'll go and export it for now. Should be
> > able to get it into rc2.  
> 
> Did this get in?  I still have people complaining about it.

It is in -rc2.  Commit 3118dac501bc.

-- 
Cheers,
Stephen Rothwell
