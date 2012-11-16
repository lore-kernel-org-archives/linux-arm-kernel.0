From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 15 Nov 2012 18:04:34 -0800
Subject: [PATCH v2 00/10] serial: sh-sci fixes - console PM, SCIFB, SMP
 lockup, etc.
In-Reply-To: <50A59B9B.2010501@renesas.com>
References: <509A0658.1010503@renesas.com> <509A0B4E.1030801@renesas.com>
 <20121116010107.GA6068@kroah.com> <50A59B9B.2010501@renesas.com>
Message-ID: <20121116020434.GA15188@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 10:49:15AM +0900, Shinya Kuribayashi wrote:
> Hi Greg,
> 
> On 11/16/2012 10:01 AM, Greg KH wrote:> On Wed, Nov 07, 2012 at 04:18:38PM +0900, Shinya Kuribayashi wrote:
> >> On 11/7/2012 3:57 PM, Shinya Kuribayashi wrote:
> >>> Hi Paul and serial forks,
> >> [...]
> >>> Takashi YOSHII (4):
> >>>       serial: sh-sci: fix condition test to set SCBRR
> >>>       serial: sh-sci: support lower baud rate
> >>>       serial: sh-sci: mask SCTFDR/RFDR according to fifosize
> >>>       serial: sh-sci: fix common SCIFB regmap definition
> >>>
> >>> Teppei Kamijou (1):
> >>>       serial: sh-sci: console runtime PM support (revisit)
> >>>
> >>>  drivers/tty/serial/sh-sci.c | 140 ++++++++++++++++++--------------------------
> >>>  1 file changed, 56 insertions(+), 84 deletions(-)
> >>
> >> Oops, I forgot to append proper From: author lines in five commits
> >> (patch 04/10 to 09/10).  Didn't mean to supersede your authoship.
> >>
> >> I'd respin the patchset later, waiting for some feedback.
> > 
> > Can you please resend this with this fixed up if you want to get this
> > into 3.8?
> 
> Thanks for your kind reminder.  Here's v2, providing From: authorship
> lines in five patches (04 to 08).  No logical change in the patches.

All now applied, thanks.

greg k-h
