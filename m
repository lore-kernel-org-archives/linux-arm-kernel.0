From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 10:10:39 +0100
Subject: [PATCH 10/19] ARM: ux500: Remove redundant #gpio-cell properties
 from HREF and Snowball DT
In-Reply-To: <CACRpkdY_gyWRO20ZOfTmG=tzE_B3ObWZG_4f8gHS6vyiGZSh6Q@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-11-git-send-email-lee.jones@linaro.org>
 <CACRpkdY_gyWRO20ZOfTmG=tzE_B3ObWZG_4f8gHS6vyiGZSh6Q@mail.gmail.com>
Message-ID: <20120914091037.GI3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 04:12:23AM -0700, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > These properties have no place here as the populated nodes are
> > not related to GPIO Controllers.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Squash this into the previous patch adding them...
> I think Arnd already noted.

Well he noted that I'd duplicated the error from the snowball.dts
file, then rectified in this patch, which is fair enough. However,
I don't think the snowball.dts fix should be squashed into an HREF
enablement patch, and I can't find a suitable patch in the patch-
set where it would really fit. Should I leave the Snowball fix
separate and just fixup the HREF .dts file to never duplicate the
anomaly?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
