From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 7 Feb 2013 10:04:21 +0100
Subject: [PATCH 1/2] clocksource: dbx500-prcmu: use relaxed readl variant
In-Reply-To: <CACRpkdacW89oq+yyjayY2674UGPdnnHS5veQsn2DaZ4-nao1Pg@mail.gmail.com>
References: <1358770172-30125-1-git-send-email-fabio.baltieri@linaro.org>
 <20130121122203.GA30289@balto.lan>
 <CACRpkdacW89oq+yyjayY2674UGPdnnHS5veQsn2DaZ4-nao1Pg@mail.gmail.com>
Message-ID: <20130207090421.GA21658@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 11:16:19AM +0100, Linus Walleij wrote:
> On Mon, Jan 21, 2013 at 1:22 PM, Fabio Baltieri
> <fabio.baltieri@linaro.org> wrote:
> > On Mon, Jan 21, 2013 at 01:09:31PM +0100, Fabio Baltieri wrote:
> >> From: Rabin Vincent <rabin.vincent@stericsson.com>
> >>
> >> Modify clksrc_dbx500_prcmu_read to replace readl() with readl_relaxed().
> >> This speeds up calls to the function by about 40%.
> >
> > Hello John,
> >
> > these two patches may go in the existing ux500 clksrc branch
> > together with the nomadik-mtu's patches queued up some time ago.
> >
> > Can I have your Acked-by for that?
> 
> Actually now when I look at it these changes are fully orthogonal
> to the other stuff, so these two should just go in through John's
> timer tree as usual.
> 
> John?

Hi John,

any feedback from this two patches?

Thanks,
Fabio

-- 
Fabio Baltieri
