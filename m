From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Jan 2015 16:39:38 +0000
Subject: [PATCH v2 RESEND 1/8] dt: bindings: Supply shared ST IRQ defines
In-Reply-To: <alpine.DEB.2.11.1501231656310.5526@nanos>
References: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
 <1421920133-7914-2-git-send-email-lee.jones@linaro.org>
 <alpine.DEB.2.11.1501231656310.5526@nanos>
Message-ID: <20150123163938.GC11745@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Jan 2015, Thomas Gleixner wrote:

> On Thu, 22 Jan 2015, Lee Jones wrote:
> 
> > These defines are used to allow values used for configuration to be
> > easily human readable and will lessen the chance of logical mistakes.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  include/dt-bindings/interrupt-controller/irq-st.h | 30 +++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 include/dt-bindings/interrupt-controller/irq-st.h
> > 
> > diff --git a/include/dt-bindings/interrupt-controller/irq-st.h b/include/dt-bindings/interrupt-controller/irq-st.h
> > new file mode 100644
> > index 0000000..4c59ace
> > --- /dev/null
> > +++ b/include/dt-bindings/interrupt-controller/irq-st.h
> > @@ -0,0 +1,30 @@
> > +/*
> > + *  include/linux/irqchip/irq-st.h
> 
> Copy & Paste?
> 
> Can we please stop adding these pointless filenames all over the
> place? They are useless and wrong in a lot of cases.

Less of a copy and paste and more and a `mv` without fixing up the
file names.  I guess they are silly, but they are rife, so someone must
think they're a good idea. :)

  for file in `find drivers -name *.c`; do head $file | grep "\.c$"; done

> Aside of that, this needs an ack from the DT folks.

I think you'll be lucky.  I haven't seen a DT review for some time
now.  Perhaps, as it's you, this might be different. ;)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
