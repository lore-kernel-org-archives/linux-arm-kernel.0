From: david.woodhouse@intel.com (Woodhouse, David)
Date: Thu, 19 Sep 2013 23:19:19 +0000
Subject: [GIT PULL] ARM: SoC fixes for 3.12-rc
In-Reply-To: <CAN8TOE8j=oosn-5hAdqoTPcuW-sGvDAHd_nK6BZfJpxMwwpisQ@mail.gmail.com>
References: <20130919194752.GA19975@quad.lixom.net>
 <1379626776.753.164.camel@shinybook.infradead.org>
 <CAN8TOE8j=oosn-5hAdqoTPcuW-sGvDAHd_nK6BZfJpxMwwpisQ@mail.gmail.com>
Message-ID: <1379632757.12963.4.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-19 at 15:57 -0700, Brian Norris wrote:
> On Thu, Sep 19, 2013 at 2:39 PM, Woodhouse, David
> <david.woodhouse@intel.com> wrote:
> > On Thu, 2013-09-19 at 12:47 -0700, Olof Johansson wrote:
> >>
> >> - A fix for build breakage in the MTD subsystem for some PXA devices.
> >>   David Woodhouse has this patch in his for-next branch but has not been
> >>   responding to our requests to send it up so here it is.
> >>   I should have amended the commit message to describe the build failure for
> >>   CONFIG_OF=n setups, but forgot and now it's down in the stack of commits.
> >
> > Thanks for pulling that in. Apologies for the screwup.
> 
> Speaking of such process issues: there's an outstanding patch for a
> (small) memory leak that was introduced in the nand_base.c ONFI code
> in 3.12-rc1. Can I expect you to attend to these sort of -rcX (where X
> > 1) issues? Or should I send Linus the patch myself? I don't really
> want it to wait around until 3.13-rc1 to go to -stable.

I'm aware of it, and will get to it shortly. Was going to round it up
along with the one that Olof just sent, either some time this week at
Plumbers or when I get home.

If you want to stick it in the linux-mtd.git tree before that and send
Linus a pull request, I have no objection.

Does that m25p80 'fix 4 byte addressing' fix for Micron not also want to
go in?

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130919/0d2e9c80/attachment-0001.bin>
