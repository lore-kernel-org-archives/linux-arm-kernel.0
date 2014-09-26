From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Sep 2014 17:16:25 +0200
Subject: [GIT PULL] Allwinner drivers additions for 3.18
In-Reply-To: <20140925191800.5855cef6@linux.lan.towertech.it>
References: <20140920202855.GA20329@lukather>
 <201409251820.38087.arnd@arndb.de>
 <20140925163103.GN15315@lukather>
 <20140925191800.5855cef6@linux.lan.towertech.it>
Message-ID: <20140926151625.GV15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 07:18:00PM +0200, Alessandro Zummo wrote:
> On Thu, 25 Sep 2014 18:31:03 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Plus, this thread from last december
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/220778.html,
> > clearly showed that it's nothing new, and that Alessandro doesn't
> > maintain any tree, hence why I ended up merging it.
> 
>  I review the drivers, when appropriate, and Andrew thankfully picks them up.
>  Important emails will usually get my attention. Even if I do not answer,
>  is always a good idea to post in the mailing list, as there are a lot
>  of competent people there.

Then may I suggest adding Andrew to the maintainers? Because if you
follow get_maintainers.pl right now, it only states that you are the
maintainer. That strongly implies that you should be the one doing
reviews, and we should at least wait for your Acked-by in order to
merge any RTC patches. And past experience show that we can wait for a
while.

Don't get this wrong, but the way you maintain it is rather unusual,
and your silence about this just makes us wonder what to do with your
patches, up until completely merging them anyway. For the record, it's
something I feel rather uncomfortable about, but it seems like it's
the only way to get something merged anyway.

Not having time to maintain your subsystem is totally fine, and as a
hobbyist maintainer too, I completely understand it. But if you can't
cope with the patches anymore, maybe you should find another
co-maintainer? Especially if you have reliable contributors, like
you're suggesting.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/a840a172/attachment-0001.sig>
