From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 11 Apr 2014 16:18:43 +0800
Subject: [PATCH RESEND 4/5] Documentation: add the Marvell Berlin
 pinctrl documentation
In-Reply-To: <20140411081259.GA20147@kwain>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-5-git-send-email-antoine.tenart@free-electrons.com>
 <20140411143318.67e55a17@xhacker> <20140411081259.GA20147@kwain>
Message-ID: <20140411161843.0bc75185@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Fri, 11 Apr 2014 01:12:59 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> Hi Jisheng,
> 
> On Fri, Apr 11, 2014 at 02:33:18PM +0800, Jisheng Zhang wrote:
> > On Thu, 10 Apr 2014 06:07:53 -0700
> > Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
> > > +Required subnode-properties:
> > > +- berlin,group: a string describing the group's name.
> > > +- berlin,function: the function used to mux the group.
> > 
> > Would it be better to s/function/mode? Because in mrvl internal technology
> > discussion and docs, we usually say "set pinmux Gy as mode z".
> 
> The pinctrl framework uses 'function', so I guess it's better not to
> introduce an other keyword that may confuse people. But I agree this is not
> what's used in the Marvell's docs. What do you think about we mention it in
> this documentation ?

That's a good idea.

Thanks,
Jisheng
