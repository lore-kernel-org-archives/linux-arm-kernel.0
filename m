From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Nov 2015 09:10:43 +0000
Subject: [RESEND v4 0/6] remoteproc: Add driver for STMicroelectronics
 platforms
In-Reply-To: <CAK=WgbZbiq_BAUEti9tWUtWqZPU_4gDJ5Mfqur=Ou2N4Ea+2GQ@mail.gmail.com>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
 <CAK=WgbZbiq_BAUEti9tWUtWqZPU_4gDJ5Mfqur=Ou2N4Ea+2GQ@mail.gmail.com>
Message-ID: <20151126091043.GO12874@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Nov 2015, Ohad Ben-Cohen wrote:
> On Tue, Nov 24, 2015 at 3:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > ST's platforms often have multiple co-processors (usually ST40s or ST231s)
> > on-board.  This provides the Linux-side infrastructure to flash and boot
> > them successfully.
> >
> > This set has been tested on an STiH410-B2120.
> 
> It would be nice if you could get at least one Reviewed-by tag coming
> outside of ST (e.g., Suman or Bjorn who are actively using and
> improving remoteproc).

If you require reviews by these guys, shouldn't they be Maintainers?

> >  arch/arm/boot/dts/stih407-family.dtsi              |  70 +++++
> 
> Since this is outside of remoteproc, please have it Acked, preferably
> by ARM DT maintainer (Olof?).

The bindings have already been Acked by Rob.  So long as the DTS(I)
files conform to them, there should be no issue.  Please be aware that
the DTS(I) changes are applied to this set for your information only
and are not to be applied through the RemoteProc tree.  The usual
process to which we conform is that Maxime (the STi Maintainer) will
apply the DT changes *after* the main driver has been applied, in this
case by you.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
