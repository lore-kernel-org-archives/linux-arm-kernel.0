From: drjones@redhat.com (Andrew Jones)
Date: Thu, 12 Jan 2017 18:08:29 +0100
Subject: [kvm-unit-tests PATCH 4/6] docs: mention checkpatch in the README
In-Reply-To: <322298cd-aefa-e945-d3f4-1237767a06ef@redhat.com>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
 <20170111162841.15569-5-alex.bennee@linaro.org>
 <322298cd-aefa-e945-d3f4-1237767a06ef@redhat.com>
Message-ID: <20170112170829.v7epg6lqhskc6ygs@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 01:29:52PM +0100, Paolo Bonzini wrote:
> 
> 
> On 11/01/2017 17:28, Alex Benn?e wrote:
> > Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> > ---
> >  README.md | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/README.md b/README.md
> > index 5027b62..9462824 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -79,3 +79,4 @@ You can add the following to .git/config to do this automatically for you:
> >      [format]
> >          subjectprefix = kvm-unit-tests PATCH
> >  
> > +Please run the kernel's ./scripts/checkpatch.pl on new patches
> 
> Does it really work well on kvm-unit-tests?

I use it on new code (liberally ignoring stuff I don't think
is worth conforming to), but there's no chance it'll work on
old files (many lib files and pretty much all x86 files). So
we can't really enforce for x86 developers, as we prefer
consistency over kernel style. That said, I think mentioning
in the README that new files could use it (at least for guidance)
is a good idea.

Thanks,
drew
