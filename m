From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Aug 2012 22:04:08 +0800
Subject: [PATCH] efikamx: reintroduce Genesi Efika MX Smarttop via device
 tree
In-Reply-To: <CAKGA1bmd-53G=59F7Nsd3Sx2eEQgvcahnt3g5zxJAGawtc-gWQ@mail.gmail.com>
References: <1344375978-29981-1-git-send-email-matt@genesi-usa.com>
 <20120808151555.GE14718@S2101-09.ap.freescale.net>
 <CAKGA1bkbp8_z+HSr97cp_jeCrdTHkQxuZPFu0QPWwnXphWVdZA@mail.gmail.com>
 <CAOMZO5DOEfV4wTSNW8ABaUhGwa_KG3Bkt0o-rs8k-cZk4P-=+A@mail.gmail.com>
 <CAKGA1bkOo=En2P18FaBpq_KAZ88kisikXhNTabvnDknQ-EwFjA@mail.gmail.com>
 <20120810014119.GD19617@S2101-09.ap.freescale.net>
 <CAKGA1bmd-53G=59F7Nsd3Sx2eEQgvcahnt3g5zxJAGawtc-gWQ@mail.gmail.com>
Message-ID: <20120810140406.GB3409@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 08:36:02AM -0500, Matt Sealey wrote:
> Requiring it breaks the entire concept of the device tree to describe running
> hardware. It is not a configuration script. pinctrl should be optional
> - built in
> always, but not necessary to turn a board on if it's already configured.
> 
How would kernel know if it's already configured, correctly?

> What would happen if a board were designed that only used the default ALT
> settings on i.MX53 or so? You'd have to redefine every default IOMUX pad
> just to get it to boot. That's intolerable.
> 
Come on, even the pad configuration are all the default?  Even if that's
the case, yes, we still need to do it.  How do we know if firmware has
changed the settings or not.

-- 
Regards,
Shawn
