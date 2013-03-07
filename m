From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 7 Mar 2013 15:17:35 +0530
Subject: [PATCH] dma: Remove erroneous __exit and __exit_p() references
In-Reply-To: <CAMhs6YwC+Lx0Vt=w2MoQV08on+rB1zidGCsNHRqcst8KBrb2XQ@mail.gmail.com>
References: <1361318824-22287-1-git-send-email-maxin.john@gmail.com>
 <CACRpkdZamOCWHWMcFYRqQDKJARZOCEP_eSNPNaxSgHfAn2wmEw@mail.gmail.com>
 <CAMhs6YwC+Lx0Vt=w2MoQV08on+rB1zidGCsNHRqcst8KBrb2XQ@mail.gmail.com>
Message-ID: <20130307094735.GG13370@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 10:17:40AM +0100, Maxin B. John wrote:
> Hi,
> 
> On Fri, Feb 22, 2013 at 7:29 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Feb 20, 2013 at 1:07 AM,  <maxin.john@gmail.com> wrote:
> >
> >> From: "Maxin B. John" <maxin.john@enea.com>
> >>
> >> Removing the annotation with __exit and referencing with __exit_p()
> >> present in dma driver module remove hooks.
> >>
> >> Part of the __devexit and __devexit_p() purge.
> >>
> >> Signed-off-by: Maxin B. John <maxin.john@enea.com>
> >
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Gentle ping...
???

Its already in my -next

--
~Vinod
