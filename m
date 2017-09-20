From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Sep 2017 09:24:43 +0100
Subject: [PATCH v7 2/8] mfd: wm97xx-core: core support for wm97xx Codec
In-Reply-To: <20170919160422.l7lxmfl6yrjnpalb@sirena.co.uk>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
 <20170913193723.16234-3-robert.jarzmik@free.fr>
 <20170914074146.dnibkvom4yuzejf3@dell>
 <20170914074300.iobuwn2hrmnf6sen@dell>
 <20170914160453.gys3imt4eobckcrq@sirena.org.uk>
 <20170918085236.z6gmgrwvsjvvc4cd@dell>
 <20170919121539.mz2mettkefxf3oer@sirena.co.uk>
 <20170919152253.tvj3hheggrx4lgig@dell>
 <20170919160422.l7lxmfl6yrjnpalb@sirena.co.uk>
Message-ID: <20170920082443.cqimrbhddum23lof@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Sep 2017, Mark Brown wrote:

> On Tue, Sep 19, 2017 at 04:22:53PM +0100, Lee Jones wrote:
> 
> > Normally I wait until all patches patches in the set have been
> > reviewed (the ASOC ones still have not), then ask the OP and the
> 
> I've been fine with them for ages.
> 
> > other affected Maintainers how they want to deal with the patch.
> > Far more often than not, the the solution is just to take the set
> > through the MFD tree.
> 
> It really helps if we can get the earlier parts of the series moving
> even if the rest of it's in review still - I know I back off on
> reviewing things if it looks like their dependencies aren't making
> progress.

Just for your FYI, I tend to review my parts then wait for the
rest of the series to be reviewed, then discuss how the set should be
handled.

Holding back on reviewing your parts is not a good idea.  If everyone
did that we'd end up in a circular Maintainer dependency and nothing
would ever get reviewed.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
