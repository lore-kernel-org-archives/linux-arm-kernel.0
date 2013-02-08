From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Feb 2013 13:40:10 -0500 (EST)
Subject: [PATCH RESEND] ARM: sched: correct update_sched_clock()
In-Reply-To: <20130208150317.GT17833@n2100.arm.linux.org.uk>
References: <1360128076-8555-1-git-send-email-iamjoonsoo.kim@lge.com>
 <CACRpkdbwoExxKbbvBKpt_Wh9KsgCXQW566N-0BaeL3oGY8pvLg@mail.gmail.com>
 <20130206163355.GH17833@n2100.arm.linux.org.uk>
 <20130208065125.GA20440@lge.com>
 <20130208150317.GT17833@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1302081331000.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Feb 2013, Russell King - ARM Linux wrote:

> On Fri, Feb 08, 2013 at 03:51:25PM +0900, Joonsoo Kim wrote:
> > I try to put it into patch tracker, but I fail to put it.
> > I use following command.
> > 
> > git send-email --to patches at arm.linux.org.uk 0001-ARM-sched-correct~~~~~
> > 
> > Am I wrong?
> > Could you teach me how to put patch into your patch tracker?
> > I already read "help" on your website, but I can't find any stuff for
> > "git send-email".
> 
> I've never used git to send email, so I'm afraid I can't help with that.
> Maybe someone with more experience with sending email from git can
> comment?

The commit text for the patch needs to contain the following 2 lines at 
the very bottom in order to match the patch system's expectations:

PATCH FOLLOWS
KernelVersion: v3.8

The KernelVersion value needs to be adjusted of course.

Note: I never tried it myself but it ought to work.

Nicolas
