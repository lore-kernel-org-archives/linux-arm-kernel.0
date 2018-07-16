From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Jul 2018 00:59:26 -0700
Subject: Vibrations on Droid 4?
In-Reply-To: <20180715201729.GB19675@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd> <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
Message-ID: <20180716075926.GU99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180715 20:20]:
> Yep, so I have two patches that make the device appear, but vibrations
> still do not work for me.
> 
> a) any ideas how to debug that / get them to work?

Hmm no new ideas except I wonder if there is also some other
regression with the timer pdata not being passed properly now.

> b) do you want the patches anyway?

Yes for things that are obviously broken it makes sense.

Thanks,

Tony
