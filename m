From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jun 2014 11:50:01 +0100
Subject: [PATCH] ARM: stih41x: Rename stih416-b2020-revE.dts to
 stih416-b2020e.dts
In-Reply-To: <CALNtEFic8xNRsx2jSj6z7Zw7YL2U+1gJ=THNw6t_LM5u8Y5o7g@mail.gmail.com>
References: <1403087508-6710-1-git-send-email-lee.jones@linaro.org>
 <CALNtEFic8xNRsx2jSj6z7Zw7YL2U+1gJ=THNw6t_LM5u8Y5o7g@mail.gmail.com>
Message-ID: <20140618105001.GB8300@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jun 2014, Srinivas Kandagatla wrote:

> Shouldn?t you do the same in Makefile?

Ah balls!  That's what happens when you rush.

Respinning.

> On Wed, Jun 18, 2014 at 11:31 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Two reasons for this rename.  Firstly, it removes the camel case
> > convention which isn't used by any other platform and secondly it
> > matches the naming convention for the internal kernel, which can
> > become annoying when flipping between the two.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/{stih416-b2020-revE.dts => stih416-b2020e.dts} | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename arch/arm/boot/dts/{stih416-b2020-revE.dts => stih416-b2020e.dts}
> > (100%)
> >
> > diff --git a/arch/arm/boot/dts/stih416-b2020-revE.dts
> > b/arch/arm/boot/dts/stih416-b2020e.dts
> > similarity index 100%
> > rename from arch/arm/boot/dts/stih416-b2020-revE.dts
> > rename to arch/arm/boot/dts/stih416-b2020e.dts
> >
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
