From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Dec 2012 10:45:25 -0800
Subject: [GIT PULL v2] ARM: arm-soc fixes for 3.8
In-Reply-To: <CAOesGMgxXmXUW2RP_5AxJ6Z5sRBhFJ2CQz4S12MwXAb3=ibYOA@mail.gmail.com>
References: <20121220163814.GA29557@quad.lixom.net>
 <20121220175639.GA14363@n2100.arm.linux.org.uk>
 <CAOesGMgxXmXUW2RP_5AxJ6Z5sRBhFJ2CQz4S12MwXAb3=ibYOA@mail.gmail.com>
Message-ID: <20121220184525.GC21056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [121220 10:11]:
> 
> Yep, I forgot to bring the fixes branch into our for-next. Try again
> once it mirrors out, I just pushed out a rebuild of it. New top commit
> should be e691d77e8825054376b31e79a9b5f9fa79fe764d.
> 
> I'm doing a "build all defconfigs" run before sending the incremental
> pull request of fixes to Linus.

Commit e691d77e8825054376b31e79a9b5f9fa79fe764d builds and
boots with my testconfigs.

I'm seeing the "BUG: spinlock bad magic on CPU#0" issue
reported and fixed here:

http://marc.info/?l=linux-arm-kernel&m=135594868503683&w=2

But that's probably been already posted as a proper patch
somewhere?

Regards,

Tony
