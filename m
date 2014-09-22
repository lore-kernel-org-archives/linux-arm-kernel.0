From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 22 Sep 2014 08:57:45 +0200
Subject: [PATCH 1/2] bus: brcmstb_gisb: register the fault code hook
In-Reply-To: <20140921231010.GN7362@norris-Latitude-E6410>
References: <1411155880-23447-1-git-send-email-f.fainelli@gmail.com>
 <1411155880-23447-2-git-send-email-f.fainelli@gmail.com>
 <20140920151950.443b7ea9@free-electrons.com>
 <20140921231010.GN7362@norris-Latitude-E6410>
Message-ID: <20140922085745.1c515be8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian,

On Sun, 21 Sep 2014 16:10:10 -0700, Brian Norris wrote:

> > I don't have the entire context, but if your platform is part of
> > multi-platform, it means that regardless of which platform is actually
> > booting your system, you will register your fault hook. Is this the
> > intended behavior?
> > 
> > Generally speaking, in a multiplatform context, many arch_initcall()
> > should have a conditional to check whether we're really on a platform
> > where the initcall is needed.
> 
> Florian already sent v2, about which I already made a similar comment:
> 
>   https://lkml.org/lkml/2014/9/19/516

Yes, sorry. I saw your review after I sent my e-mail :)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
