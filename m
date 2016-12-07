From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2016 12:34:12 -0800
Subject: [PATCH v2 1/2] arm64: dts: zx: Fix gic GICR property
In-Reply-To: <20161206011244.GC2749@dragon>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <1476361881-19685-2-git-send-email-jun.nie@linaro.org>
 <a243d381-f7ab-abed-ca21-f0951abb04fd@arm.com>
 <3937871.l5gZt4hBke@wuerfel> <20161205022451.GA2749@dragon>
 <CAOesGMhNJhOZDFvVzU3nVySZLf4N4Rk2mvjb3se_f_1_N=zk3Q@mail.gmail.com>
 <20161206011244.GC2749@dragon>
Message-ID: <20161207203412.GA10158@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 09:12:46AM +0800, Shawn Guo wrote:
> Hi Olof,
> 
> On Mon, Dec 05, 2016 at 04:55:02PM -0800, Olof Johansson wrote:
> > Hi Shawn,
> > 
> > On Sun, Dec 4, 2016 at 6:24 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > > Hi Arnd,
> > >
> > > On Fri, Dec 02, 2016 at 09:28:58PM +0100, Arnd Bergmann wrote:
> > >> Given that there is any concern about the patch now, and the merge
> > >> window is almost open, I'm moving both patches to the
> > >> next/fixes-non-critical branch and will merge it for v4.10 instead
> > >> of sending it for v4.9.
> > >>
> > >> If you end up deciding that the patch is wrong, please follow up
> > >> with a fix on top. Once the situation is resolved and the patch
> > >> merged upstream, feel free to ask stable at vger.kernel.org for a
> > >> backport to stable kernels to get it into v4.9.x.
> > >
> > > The patch is correct, though it can be cleaned up a bit further per
> > > Marc's suggestion.  Since we now have 4.9-rc8, I'm wondering if we can
> > > still get this into 4.9 to save the stable kernel backport.
> > >
> > > I sent you a cleanup patch on top of this one yesterday.  If you like,
> > > I can quickly resend the patch with the cleanup squashed.
> > 
> > Since the patches have already been applied, an incremental patch to
> > apply on top would work best here.
> 
> No problem.  So would you please apply the incremental patch [1] to the
> same branch?  Or I can send it to you later during -rc cycles.  Just let
> me know your preference.
> 
> Shawn
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg546957.html

So, it seems that Arnd didn't apply the old patch to fixes-non-critical, or
at least didn't push out after doing it. So, I've done that now, as well as
applied the fixup you have above.


-Olof
