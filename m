From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Jul 2016 12:31:06 +0200
Subject: [PATCH v5 2/3] pwm: iproc: Add support for Broadcom iproc pwm
 controller
In-Reply-To: <CAL2FKYkH86zhPOrEZQ8Q=WeKUV=2KFfxfA-JTrxiqMnCceQ87g@mail.gmail.com>
References: <CAL2FKYkH86zhPOrEZQ8Q=WeKUV=2KFfxfA-JTrxiqMnCceQ87g@mail.gmail.com>
Message-ID: <20160711103106.GA5503@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 12:22:38PM +0530, Yendapally Reddy Dhananjaya Reddy wrote:
> Hi Thierry,
> 
> On Fri, Jul 8, 2016 at 8:46 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Tue, Jul 05, 2016 at 02:00:25AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
> >> Add support for the PWM controller present in Broadcom's iProc
> >> family of SoCs.It has been tested on the  Northstar+ bcm958625HR board.
> >>
> >> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> >> ---
> >>  drivers/pwm/Kconfig         |  10 ++
> >>  drivers/pwm/Makefile        |   1 +
> >>  drivers/pwm/pwm-bcm-iproc.c | 268 ++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 279 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c
> >
> > I've applied this, but I had to make a couple of changes for coding
> > style and to squash compiler warnings. Please check the PWM tree's
> > for-next branch to see if it still works for you.
> >
> 
>   Thanks. It is working fine for me. A small change is required here,
> NSEC_PER_SEC
> instead of USEC_PER_SEC in two places.

Ah yes, I had mixed those up when converting from literal to symbolic.
Should be fixed now.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/b1d1a522/attachment.sig>
