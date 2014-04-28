From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 Apr 2014 08:33:47 -0700
Subject: [PATCH 1/4] mfd: twl4030-power: Add recommended idle configuration
In-Reply-To: <20140428114133.GV21279@lee--X1>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-2-git-send-email-tony@atomide.com>
 <20140428114133.GV21279@lee--X1>
Message-ID: <20140428153346.GI20807@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lee Jones <lee.jones@linaro.org> [140428 04:42]:
> > These settings are based on the "Recommended Sleep Sequences for
> > the Zoom Platform" pdf at:
> > 
> > http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf
> > 
> > These settings assume most of the regulators are under control of
> > Linux, and cuts off VDD1 and VDD2 during off-idle as Linux cannot
> > do it.
> 
> Linux does it becuase Linux can't do it. Eh?

Heh yeah that's confusing, will update to:

These settings assume most of the regulators are under control of
Linux, and twl4030 only cuts off VDD1 and VDD2 during off-idle as
Linux cannot do it.

Regards,

Tony
