From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Apr 2014 09:16:04 +0800
Subject: [PATCH 1/2] ARM: dt-binding: fix GIC example
In-Reply-To: <CAL_Jsq+_+B=TKMQ2ULkXiBJGTNmGGLkB1xjKNJkF1BK_4TRXkg@mail.gmail.com>
References: <1396023951-32383-1-git-send-email-l.stach@pengutronix.de>
 <CAL_Jsq+_+B=TKMQ2ULkXiBJGTNmGGLkB1xjKNJkF1BK_4TRXkg@mail.gmail.com>
Message-ID: <20140411011602.GF28420@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 10:21:35AM -0500, Rob Herring wrote:
> On Fri, Mar 28, 2014 at 11:25 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > From: Tim Harvey <tharvey@gateworks.com>
> >
> > When using interrupt-maps, the size of a map entry is #address-cells +
> 
> Plus what? You mean ", and "?
> 
> > address-cells should be 0 as this is not used.
> >
> > As #address-cells = <0> is the same as not specifying the
> > property, simply remove it.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Did this get applied? I can't seem to find patch 2.

No.  We expect this patch to be applied on DT tree, while the
patch #2 [1] is going through IMX tree.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg318810.html
