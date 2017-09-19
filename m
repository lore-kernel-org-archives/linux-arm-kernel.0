From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Sep 2017 13:20:31 +0200
Subject: [PATCH] arm64: dts: draak: Add serial console pins
In-Reply-To: <CAMuHMdVCUcy48qDvDSDZ9MAgCLiSUd4zgFD2iu5eWkTVinN1Jw@mail.gmail.com>
References: <1503912370-20180-1-git-send-email-geert+renesas@glider.be>
 <20170830064402.GB10398@verge.net.au>
 <CAMuHMdVCUcy48qDvDSDZ9MAgCLiSUd4zgFD2iu5eWkTVinN1Jw@mail.gmail.com>
Message-ID: <20170919112028.GD7933@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 11:13:25AM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 30, 2017 at 8:44 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Aug 28, 2017 at 11:26:10AM +0200, Geert Uytterhoeven wrote:
> >> Add pin control for SCIF2.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> To be applied after v4.14-rc1, when commit 794a6711764658a1 ("pinctrl:
> >> sh-pfc: Initial R8A77995 PFC support") has hit mainline.
> >>
> >> Else the serial console will fail, reporting (on earlycon):
> >>
> >>     sh-sci e6e88000.serial: could not find pctldev for node /soc/pin-controller at e6060000/scif2, deferring probe
> >
> > Thanks, please ping me once that has happened.
> > In the meantime I have marked this patch as deferred.
> 
> Ping...

Thanks, applied.
