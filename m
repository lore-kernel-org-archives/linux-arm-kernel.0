From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 24 Jan 2013 21:27:24 +0100
Subject: [RFC PATCH 6/6] ARM: kirkwood: consolidate mv643xx_eth init for DT
In-Reply-To: <20130124181622.GD1758@titan.lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <510174AF.4020503@openwrt.org> <20130124181622.GD1758@titan.lakedaemon.net>
Message-ID: <3084778.eWbl5o3HSt@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 January 2013 13:16:22 Jason Cooper wrote:
> > >Ian's patch appears to do so.  I'll respin this series using it vice my
> > >lookup table.
> > >
> > Sounds good, while at it, I wonder if we could not simplify Ian's
> > patch to be limited to the actual Ethernet MAC driver and use
> > Thomas's mvdio device tree binding for the MDIO bits of mv643xx_eth.
> > What do you think?
> 
> It sounds like you just volunteered ;-)  Do you think you have the time
> to knock it out for v3.9?

I do not have any kirkwood board at the moment and I really want to be able to 
test this properly especially with the "clock must be enabled for ethernet not 
be lost". Let me get one and I should be able to do it. Let's adopt your patch 
for the moment, and once I have a kirkwood board I can deal with the ethernet 
driver device tree bindings.

Does that sound ok with you?

> 
> I'd like to drop most of these board-*.c files for v3.9.  They've been
> bugging me since I added the first one (board-dreamplug.c).
> 
> thx,
> 
> Jason.
-- 
Florian
