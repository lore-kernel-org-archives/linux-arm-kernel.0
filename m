From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 17:35:38 +0200
Subject: pinctrl: mvebu: minor fixes
In-Reply-To: <CABJ1b_Se0w2W+LHhknUqYOBQurCdmYbWnkxX8hJhOFkXAo30xg@mail.gmail.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347373204-17883-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CABJ1b_Se0w2W+LHhknUqYOBQurCdmYbWnkxX8hJhOFkXAo30xg@mail.gmail.com>
Message-ID: <20120911173538.7e7d9fe7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 11 Sep 2012 17:31:56 +0200,
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> a ?crit :

> thanks for this one! After reviewing the offending code, I realized
> that it must
> be an old(er) version of the pinctrl core. I ll dig out the correct
> version and report
> on list accordingly.

Ok, great. The version you had sent looked really strange/unfinished to
me, so happy to know there's a more finalized version somewhere :-)

I'll test it as soon as you post it, to validate that it works OK on
Armada 370/XP.

That said, I'm still interested by a short human-readable summary of
the changes you've done in terms of how the 'functions' are handled
compared to the original version of the driver.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
