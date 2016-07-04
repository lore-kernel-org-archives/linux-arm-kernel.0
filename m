From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 4 Jul 2016 13:19:33 +0800
Subject: [GIT PULL] drm/mediatek: MT8173 gamma & dither support
In-Reply-To: <CACvgo52YgRat8Uqhd9qh_ppvk0h=krxYLHL6Cjqs9+EzQaogUg@mail.gmail.com>
References: <1466753238-17216-1-git-send-email-bibby.hsieh@mediatek.com>
 <558c9efc-d197-a6c3-cf7e-f9fcac60ca64@gmail.com>
 <1467026970.23883.16.camel@mtksdaap41>
 <CACvgo52YgRat8Uqhd9qh_ppvk0h=krxYLHL6Cjqs9+EzQaogUg@mail.gmail.com>
Message-ID: <1467609573.31010.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Emil:

On Sun, 2016-07-03 at 23:43 +0100, Emil Velikov wrote:
> Hi Bibby,
> 
> On 27 June 2016 at 12:29, Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
> > On Mon, 2016-06-27 at 12:20 +0200, Matthias Brugger wrote:
> >>
> >> On 06/24/2016 09:27 AM, Bibby Hsieh wrote:
> >> > Hi Dave,
> >> >
> >> > Please consider merging this tag, which contains the v2 MT8173 gamma & dither function patches I sent on 2016-06-17, rebased onto v4.7-rc1. There have been no further comments.
> >> >
> >> > Thanks
> >> > Bibby
> >> >
> >> > The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> >> >
> >> >   Linux 4.7-rc1 (2016-05-29 16:29:24 GMT)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   git at github.com:BibbyHsieh/linux4.7-rc1.git
> >> >
> >> > for you to fetch changes up to dd0eb773bc125f5e6bca735d19c08500dc3730f9:
> >> >
> >> >   drm/mediatek: Add gamma correction
> >> >
> >> > -------------------------------------------------------------------------
> >>
> >> As far as I can see, your branch has 3 patches on top from Eddie. It
> >> seems to me as if you didn't send your patches to the mailinglist before?
> >> Anyway this branch does not fulfill the rules to get merged into the
> >> linux kernel.
> >>
> >> Why do you send a pull request? The normal process is to send the
> >> patches via email and if the maintainer wants you can send a pull
> >> request once the patches are ready to be merged.
> >>
> >> Regards,
> >> Matthias
> >>
> >
> > I sent v1 and v2 on 2016-06-14 and 06-17 respectively [0-8].
> > After I made some modifications according to Daniel Vetter's comments,
> > there had been no further comments and I sent the pull request as the
> > other sub-sys.
> >
> > I'm sorry for my mistake, I will re-arrange the tree for upstream.
> > Next time, I will check with maintainer by email first, and sent the
> > pull request.
> >
> It might be a bit hard to find out who's the maintainer considering
> MAINTAINERS has no entry for this driver.
> 
> Looking at how things are going Philipp Zabel will be the more likely
> person for the task, yet I would be nice if someone from the Mediatek
> squad is helping him out - CK Hu perhaps ?
> 
> Regards,
> Emil

I'm willing to be one of Mediatek DRM driver maintainer. I wish this
would make things easier.

Regards,
CK
