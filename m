From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 5 Oct 2012 16:20:04 +0200
Subject: [PATCH 1/1] mtd: st fsmc_nand: pass the ale and cmd resource
 via resource
In-Reply-To: <CACRpkdb10dfKR-sAvbUar+ZsC16uLofhBXuMxfL7QtXLhNg1+Q@mail.gmail.com>
References: <1349356456-13371-1-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdb10dfKR-sAvbUar+ZsC16uLofhBXuMxfL7QtXLhNg1+Q@mail.gmail.com>
Message-ID: <20121005142004.GB12462@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:49 Fri 05 Oct     , Linus Walleij wrote:
> 
> On Thu, Oct 4, 2012 at 3:14 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> 
> > Do not use the platform_data to pass resource and be smart in the drivers.
> > Just pass it via resource
> >
> > Switch to devm_request_and_ioremap at the sametime
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Vipin Kumar <vipin.kumar@st.com>
> > Cc: linux-mtd at lists.infradead.org
> 
> This is much better. Actually I was confused by these offsets recently...
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> My patch to convert the Nomadik to the FSMC driver will collide with this,
> but I can sure fix it up as we run into it, no big deal.
ha you did it too

I'll give it a try

Best Regards,
J.
