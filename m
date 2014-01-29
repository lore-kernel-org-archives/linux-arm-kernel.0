From: richard@nod.at (Richard Weinberger)
Date: Wed, 29 Jan 2014 16:56:04 +0100
Subject: [BUG] reproducable ubifs reboot assert and corruption
In-Reply-To: <20140129154622.GB7278@gmail.com>
References: <20140122051510.GB17284@gmail.com>
 <CAFLxGvwmzftdQKSjjjwpFLS8g3EJqMrQ2gU2scBsh2MvG7Wyyw@mail.gmail.com>
 <20140127163939.GA27809@gmail.com> <20140129053238.GA6035@gmail.com>
 <52E8AE25.8080502@nod.at> <20140129154622.GB7278@gmail.com>
Message-ID: <52E92494.1090407@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 29.01.2014 16:46, schrieb Andrew Ruder:
> On Wed, Jan 29, 2014 at 08:30:45AM +0100, Richard Weinberger wrote:
>> BTW: Can you please share your .config?
> 
> No problem.  FYI, this is for a board that is still in development so
> not all my changes have been submitted for inclusion yet.  I would be
> happy to share the changes now if necessary but I've attached the --stat
> to show that as far as mtd/ubifs goes, i'm basically running a stock
> v3.12:

Does the issue also happen if you disable preemption?
i.e. CONFIG_PREEMPT_NONE=y

Maybe it is really a race...

Thanks,
//richard
