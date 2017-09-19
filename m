From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Sep 2017 16:23:49 +0100
Subject: [PATCH v7 2/8] mfd: wm97xx-core: core support for wm97xx Codec
In-Reply-To: <20170919152253.tvj3hheggrx4lgig@dell>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
 <20170913193723.16234-3-robert.jarzmik@free.fr>
 <20170914074146.dnibkvom4yuzejf3@dell>
 <20170914074300.iobuwn2hrmnf6sen@dell>
 <20170914160453.gys3imt4eobckcrq@sirena.org.uk>
 <20170918085236.z6gmgrwvsjvvc4cd@dell>
 <20170919121539.mz2mettkefxf3oer@sirena.co.uk>
 <20170919152253.tvj3hheggrx4lgig@dell>
Message-ID: <20170919152349.2dks77acrnv27mto@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Sep 2017, Lee Jones wrote:

> On Tue, 19 Sep 2017, Mark Brown wrote:
> 
> > On Mon, Sep 18, 2017 at 09:52:36AM +0100, Lee Jones wrote:
> > > On Thu, 14 Sep 2017, Mark Brown wrote:
> > 
> > > > On Thu, Sep 14, 2017 at 08:43:00AM +0100, Lee Jones wrote:
> > 
> > > > > Change of plan.  It looks like there are deps.
> > 
> > > > > Unapplied.
> > 
> > > > The core stuff went in during the merge window, you should be able to
> > > > wait for -rc1 or pick up the asoc-v4.14 tag.
> > 
> > > No, I mean patches; 3, 4, 5 and 7 depend on this file.
> > 
> > Right, but I'd have expected a pull request more than the patch being
> > unapplied?
> 
> Normally I wait until all patches patches in the set have been
> reviewed (the ASOC ones still have not), then ask the OP and the
> other affected Maintainers how they want to deal with the patch.
> Far more often than not, the the solution is just to take the set
> through the MFD tree.
> 
> However, since this is a new driver, you can just take it with my:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

... although that does mean that you'll have to handle one of the
Input patches too.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
