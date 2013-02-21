From: wd@denx.de (Wolfgang Denk)
Date: Fri, 22 Feb 2013 00:18:48 +0100
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
 <20130221211444.GB20114@obsidianresearch.com>
 <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
Message-ID: <20130221231848.880DE200552@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Nicolas,

In message <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg> you wrote:
> 
> No it is not.  FIT is about bundling a multi-platform kernel with a 
> bunch of DTBs together in a single file.  I don't think you need that 

Actually this is neither the only, nor even the primary purpose of FIT
images; these have a much wider scope of usage scenarios.

> The DT is meant to describe hardware.  As far as I know, the hardware I 
> own seems to be rather static and stable, and unlike software there is 
> no way I can change it (soldering irons don't count).

There is other hardware available (for example FPGA based) where this
does not apply.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
GUIs  are  virtually  useless.  Learn  tools.  They're  configurable,
scriptable, automatable, cron-able, interoperable, etc. We don't need
no brain-dead winslurping monolithic claptrap.
                               -- Tom Christiansen in 371140df at csnews
