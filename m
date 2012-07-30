From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Mon, 30 Jul 2012 16:35:01 +0530
Subject: [PATCH 1/3] Move FIMD register headers to include/video/
In-Reply-To: <50164A8B.3070907@samsung.com>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
 <1343637905-17764-2-git-send-email-l.krishna@samsung.com>
 <50164A8B.3070907@samsung.com>
Message-ID: <CAL1wa8fc30-9C=2Rx9WJCPVPcAPvBDo25eCkoyCkm73-jG_jgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sylwester,

On Mon, Jul 30, 2012 at 2:19 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> Hi,
>
> On 07/30/2012 10:45 AM, Leela Krishna Amudala wrote:
> > Moved the contents of regs-fb-v4.h and regs-fb.h from arch side
> > to include/video/samsung_fimd.h
> >
> > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> > ---
> >  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 -------
> >  arch/arm/plat-samsung/include/plat/regs-fb.h    |  403 -----------------
> >  include/video/samsung_fimd.h                    |  533 +++++++++++++++++++++++
> >  3 files changed, 533 insertions(+), 562 deletions(-)
> >  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
> >  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
> >  create mode 100644 include/video/samsung_fimd.h
>
> Thanks for taking care if this. However you might need to split this
> patch in two, so there is no build and git bisection breakage. In the
> first patch a new header file would be added, then the patch updating
> users of the FIMD headers would be applied, and finally the regs-fb*.h
> files would be removed.
>
> Also it helps to use -M option to git format-patch when creating patches
> that mainly move files.
>

Will do it in the suggested way,
Thanks for reviewing the patch.

> --
>
> Regards,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
