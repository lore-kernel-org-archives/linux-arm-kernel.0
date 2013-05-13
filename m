From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 13 May 2013 12:51:48 +0200
Subject: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to
 drivers/cpufreq
In-Reply-To: <CAKohpomV9-JEbuHWdmp6N+bKYt+83hXXcqg4aKXSY1a5zwpW9Q@mail.gmail.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <5176A807.2090005@samsung.com>
 <CAKohpomV9-JEbuHWdmp6N+bKYt+83hXXcqg4aKXSY1a5zwpW9Q@mail.gmail.com>
Message-ID: <105283277.osOpfTKkgk@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 13, 2013 11:35:22 AM Viresh Kumar wrote:
> On 23 April 2013 20:55, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > On 04/05/13 20:36, Rafael J. Wysocki wrote:
> >>
> >> On Friday, April 05, 2013 12:36:34 PM Viresh Kumar wrote:
> >>>
> >>> On 5 April 2013 12:18, Kukjin Kim<kgene.kim@samsung.com>  wrote:
> >>>>
> >>>> Basically, this moving looks good to me, but should be re-worked based
> >>>> on
> >>>> for-next of samsung tree because this touches too many samsung stuff so
> >>>> this
> >>>> should be sent to upstream via samsung tree.
> >>>
> >>>
> >>> Hmm... Its already applied in Rafael's tree. But it doesn't mean that
> >>> it can't be
> >>> moved to your tree if there is a issue.
> >>
> >>
> >> Well, I'm dropping it.  Please merge via the Samsung tree.
> >>
> >
> > Oops, I missed, maybe I have no more chance to send this to upstream for
> > upcoming merge window :-(
> >
> > Rafael, please take this patch with my ack in your tree, sorry for noise.
> >
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> >
> > If any problems, please kindly let me know.
> 
> Who is going to pick this patch now for next merge window?

That doesn't matter I suppose.  I can take it, but please rebase it on top
of current linux-next.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
