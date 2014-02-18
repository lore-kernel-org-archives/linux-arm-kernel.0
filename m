From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Feb 2014 14:13:03 +0100
Subject: [PATCH] net: ethernet: remove unneeded dependency of mvneta and
 update help text
In-Reply-To: <20140218125206.GN7862@titan.lakedaemon.net>
References: <1392719391-8851-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218122952.GM7862@titan.lakedaemon.net>
 <20140218134532.7607a616@skate>
 <20140218125206.GN7862@titan.lakedaemon.net>
Message-ID: <20140218141303.77c77272@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 18 Feb 2014 07:52:06 -0500, Jason Cooper wrote:

> > No, I haven't tested all the build scenarios of course. If you feel
> > that this is too dangerous, I can resend a patch that replaces 'depends
> > on ARMADA_370_XP' by 'depends on PLAT_ORION'. Would this be OK for you?
> 
> I'm fine either way.  I'm definitely a "What's in the box?" kind of guy.
> But I do like being prepared.

And it's all in your honour!

> The real question is: Do you think this IP block will ever be found on
> anything other than Marvell Armada boards?  If so, stick with this
> version and build test the crap out of it.  Otherwise, let's save
> opening the box for another day.

At this point, I don't expect to see this IP in any other SOCs than
Marvell Armada EBU, so I'll resend with a "depends on PLAT_ORION", as I
agree it is much safer in terms of build problems.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
