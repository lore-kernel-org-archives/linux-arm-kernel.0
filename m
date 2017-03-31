From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 31 Mar 2017 11:23:45 +0100
Subject: [PATCH 1/3] drm/arm: hdlcd: properly validate plane state
In-Reply-To: <20170331102035.GP7909@n2100.armlinux.org.uk>
References: <20170331094937.GO7909@n2100.armlinux.org.uk>
 <E1cttDZ-000671-Q1@rmk-PC.armlinux.org.uk>
 <20170331101850.GD13355@e110455-lin.cambridge.arm.com>
 <20170331102035.GP7909@n2100.armlinux.org.uk>
Message-ID: <20170331102345.GF13355@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 11:20:35AM +0100, Russell King - ARM Linux wrote:
> On Fri, Mar 31, 2017 at 11:18:50AM +0100, Liviu Dudau wrote:
> > Hi Russell,
> > 
> > You were Cc-ed in a patch from March 8th that did all this:
> > 
> > https://lists.freedesktop.org/archives/dri-devel/2017-March/135172.html
> 
> I'm aware of that (you may notice that this was threaded to that patch.)
> 
> > I have not received any response from you, so I have already pushed the
> > patch in my public repo:
> > 
> > git://linux-arm.org/linux-ld.git for-upstream/hdlcd
> > 
> > It has been included into linux-next for at least a couple of weeks now.
> 
> I've not had a chance to test any of this, but I believe that your
> patch does not fully address the issue, due to bits missing from
> the validation path.

Care to point out which bits were missing from my patch that are in yours?

Best regards,
Liviu

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
