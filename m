From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 18 Oct 2016 16:57:57 +0100
Subject: [PATCH 2/2] scripts/gdb: fixup some pep8 errors in proc.py
In-Reply-To: <477b66cc-05dc-57fa-38fb-f80510935c2e@bingham.xyz>
References: <1476803249-23328-1-git-send-email-peter.griffin@linaro.org>
 <1476803249-23328-2-git-send-email-peter.griffin@linaro.org>
 <477b66cc-05dc-57fa-38fb-f80510935c2e@bingham.xyz>
Message-ID: <20161018155757.GA24274@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

On Tue, 18 Oct 2016, Kieran Bingham wrote:

> Hi Pete,
> 
> On 18/10/16 16:07, Peter Griffin wrote:
> > proc.py:22:1: E302 expected 2 blank lines, found 1
> > proc.py:200:1: E302 expected 2 blank lines, found 1
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  scripts/gdb/linux/proc.py | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
> > index f20fcfa..2d6f74e 100644
> > --- a/scripts/gdb/linux/proc.py
> > +++ b/scripts/gdb/linux/proc.py
> > @@ -18,6 +18,7 @@ from linux import tasks
> >  from linux import lists
> >  from struct import *
> >  
> > +
> 
> This was added by patch 1, and can be squashed there.

Doh, I had deliberately done it as a separate commit, as I thought it was
a pre-existing pep8 error.

Will squash in v2.

regards,

Peter.
