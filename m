From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Jun 2013 16:12:08 +0100
Subject: [PATCH 00/10] regulator: ab8500-ext: Refactorings
In-Reply-To: <CACRpkdbygDNdsO=EzigPiBSnMmF-NVnF95HeBBavkry93i+ubQ@mail.gmail.com>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdbygDNdsO=EzigPiBSnMmF-NVnF95HeBBavkry93i+ubQ@mail.gmail.com>
Message-ID: <20130610151208.GK20297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Linus Walleij wrote:

> On Fri, Jun 7, 2013 at 6:11 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This patch aims to do the following:
> >
> >  - Separate the AB8500 External Regulator out from the AB8500 core
> >    one for added control and reduced complexity
> >  - Enable the AB8500 External Regulator for Device Tree
> >  - Ensure EXT3 supplies the AUX regulators with voltage
> 
> The series:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Once the changes to MFD+Regulator are in I'm happy to take the
> DT patches onto my ux500-devicetree branch. However I fear
> I'll break something if I do it right now?

You can apply all of the DTS changes, no problem.

The 'ux500: regulator_supply' patch, relies on the 'regulator:
supply_name' one however. Mark has taken two of them, I don't know why
the others were missed/intentionally left.

Mark, was there a reason for this?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
