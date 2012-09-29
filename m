From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Sep 2012 11:36:39 -0700
Subject: [GIT PULL 4/4] Samsung DT for v3.7
In-Reply-To: <146201cd9c4c$1a219b30$4e64d190$%kim@samsung.com>
References: <505C089C.4050801@samsung.com> <505C22CD.9030401@samsung.com>
 <146201cd9c4c$1a219b30$4e64d190$%kim@samsung.com>
Message-ID: <20120929183639.GA29547@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 10:04:53AM +0900, Kukjin Kim wrote:
> Kukjin Kim wrote:
> > 
> > On 09/21/12 15:26, Kukjin Kim wrote:
> > > Hi Arnd, Olof
> > >
> > > This is for updating Samsung DT for v3.7.
> > >
> > > But now this makes many conflicts with pinctrl dt because of moving file
> > > so I'm sorting them out to avoid useless conflicts.
> > >
> > > I'll re-send this soon again.
> > > This is jut for your information.
> > >
> > I created following branch which is merged on top of Samsung pinctrl and
> > board branches already are pulled into arm-soc.
> > 
> > This includes moving common exynos4 dt for supporting other exynos4xxxx
> > SoCs easily and adding exynos43210-trats board support and some updates.
> > 
> > Please pull from:
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > next/dt-samsung-new
> > 
> > If any problems, please kindly let me know.
> > 
> Hi Arnd and Olof,
> 
> Maybe, you missed this one?
> 
> Note, this will make conflicts with Rob's change, move all dtb targets.

Kukjin,

The branch contents is not the same as your repeated pull request, it had
patches added on the 26th and the original request was sent on the 21st. I've
pulled it anyway after reviewing those patches, but please be more transparent
with what you do to your branch if you update it after pull requests have been
sent.

Also, next time please do a full re-send of the pull request, I probably missed
it because it was a reply with just a new link and not the full diffstat, etc.


-Olof
