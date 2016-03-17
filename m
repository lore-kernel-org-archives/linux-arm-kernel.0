From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 17 Mar 2016 15:07:10 +0000
Subject: [PATCH] MAINTAINERS: Add the stlinux kernel mailing list for the
 STi drm driver.
In-Reply-To: <20160317132622.GB13692@x1>
References: <1458213210-13873-1-git-send-email-peter.griffin@linaro.org>
 <20160317132622.GB13692@x1>
Message-ID: <20160317150710.GA26662@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, 17 Mar 2016, Lee Jones wrote:

> On Thu, 17 Mar 2016, Peter Griffin wrote:
> 
> > Most drivers for STi are under the ARM/STI Architecture section which
> > includes this mailing list.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6ee06ea..c541a89 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3814,6 +3814,7 @@ DRM DRIVERS FOR STI
> >  M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
> >  M:	Vincent Abriou <vincent.abriou@st.com>
> >  L:	dri-devel at lists.freedesktop.org
> > +L:	kernel at stlinux.com
> >  T:	git http://git.linaro.org/people/benjamin.gaignard/kernel.git
> >  S:	Maintained
> >  F:	drivers/gpu/drm/sti
> 
> Doesn't it make more sense to add drivers/gpu/drm/sti/ to the ARM/STI
> ARCHITECTURE list of supported files?

I assumed Vincent and Benjamin deliberately added a new entry because they
want to be maintainers of this driver (which I think probably makes sense given
that the display IP is quite complicated).

Not seeing these patches on kernel at stlinux.com list though has caught me out,
especially recent changes applied to the firmware loading mechanism in drm/sti which
also need similar changes in c8sectpfe and fdma drivers.

regards,

Peter.
