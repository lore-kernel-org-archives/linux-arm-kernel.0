From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 19 Apr 2017 13:07:32 -0700
Subject: [PATCH v3] mtd: physmap_of: really fix the physmap add-ons
In-Reply-To: <20170331100451.069a76ab@bbrezillon>
References: <20170330153639.26819-1-linus.walleij@linaro.org>
 <20170331100451.069a76ab@bbrezillon>
Message-ID: <20170419200732.GC20555@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 10:04:51AM +0200, Boris Brezillon wrote:
> On Thu, 30 Mar 2017 17:36:39 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > The current way of building the of_physmap add-ons result in just
> > the add-on being in the object code, and not the actual core
> > implementation and regress the Gemini and Versatile.
> > 
> > Bake the physmap_of.o object by baking physmap_of_core.o and
> > adding the Versatile and/or Gemini add-ons to the final object.
> > Rename the source file physmap_of_core.c to get the desired
> > build components.
> > 
> > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Fixes: 4f04f68e1598 ("mtd: physmap_of: fixup gemini/versatile dependencies")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Applied
