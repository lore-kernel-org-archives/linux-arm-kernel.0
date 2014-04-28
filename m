From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 16:42:17 +0100
Subject: [PATCH 1/4] mfd: twl4030-power: Add recommended idle configuration
In-Reply-To: <20140428153346.GI20807@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-2-git-send-email-tony@atomide.com>
 <20140428114133.GV21279@lee--X1>
 <20140428153346.GI20807@atomide.com>
Message-ID: <20140428154217.GB24959@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Apr 2014, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [140428 04:42]:
> > > These settings are based on the "Recommended Sleep Sequences for
> > > the Zoom Platform" pdf at:
> > > 
> > > http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf
> > > 
> > > These settings assume most of the regulators are under control of
> > > Linux, and cuts off VDD1 and VDD2 during off-idle as Linux cannot
> > > do it.
> > 
> > Linux does it becuase Linux can't do it. Eh?
> 
> Heh yeah that's confusing, will update to:
> 
> These settings assume most of the regulators are under control of
> Linux, and twl4030 only cuts off VDD1 and VDD2 during off-idle as
> Linux cannot do it.

+1, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
