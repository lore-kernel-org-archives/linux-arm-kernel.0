From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 May 2013 19:52:36 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.10
In-Reply-To: <20130521064034.GE20453@quad.lixom.net>
References: <519A5933.3040005@samsung.com>
 <20130521064034.GE20453@quad.lixom.net>
Message-ID: <102901ce5611$4df09bd0$e9d1d370$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Tue, May 21, 2013 at 02:11:15AM +0900, Kukjin Kim wrote:
> > The following changes since commit
> f722406faae2d073cc1d01063d1123c35425939e:
> >
> >   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> >
> > are available in the git repository at:
> >
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-fixes-2
> 
> What happened to the 4210 rev0 regression fixes from Tomasz? I would
> have expected them in this batch?
> 
Hmm... please see below:
https://patchwork.kernel.org/patch/2478431/

Since many conflicts at that time, the 11/13 patch missed in the last merge
window. Then, seems as Tomasz replied, he re-submitted after -rc1.

OK, I will pick that up into upcoming fixes for Samsung stuff.

> Might as well hold off this one until that is reviewed and ready, since
> it's silly to keep pulling one-patch branches. At least if that's
> happening
> this week.
> 
Yeah, agreed. Let me sort out other fixes within a couple of days.

Please kindly ignore this pull request :-)

Thanks.

- Kukjin
