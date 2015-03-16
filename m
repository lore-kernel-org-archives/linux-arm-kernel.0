From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 14:01:43 -0700
Subject: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
In-Reply-To: <201503162158.50587@pali>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <2070859.WcMooC33YH@wuerfel> <20150316152939.GP5264@atomide.com>
 <201503162158.50587@pali>
Message-ID: <20150316210143.GF12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150316 13:59]:
> On Monday 16 March 2015 16:29:39 Tony Lindgren wrote:
> > I believe the last pending issues is the support for
> > ATAG_REVISION in device tree mode as posted by Pali.
> > 
> 
> No. In DT boot there is missing /proc/atags file (readable by 
> userspace processes).

Oh OK thanks for the update.

> And also broken AES/SHA/MD5 support. Fix for crypto DT stuff
> I already sent.

But this is not a regression in mainline with legacy boot vs
device tree based booting, right? Sounds like it never worked
in the mainline or am thinking of some other set of patches?

Regards,

Tony
