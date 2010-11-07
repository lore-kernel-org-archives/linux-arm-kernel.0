From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Nov 2010 19:43:45 +0000
Subject: [RFC] Removal of dead code from arch/arm/*
In-Reply-To: <AANLkTiniPdzC4YEmq5_kJwv94fGmjE65i=Cjmd9VDMg5@mail.gmail.com>
References: <AANLkTim+vj_OAd22TdThuC-HSqUiDjguOHQWjyqFaq6N@mail.gmail.com>
	<AANLkTi=Cpq2_vV2RGcoQhrqk8xpL59AvLFPzfvTBk5Xa@mail.gmail.com>
	<4CBF8BDB.7090907@gmail.com>
	<20101021075401.GC22100@n2100.arm.linux.org.uk>
	<AANLkTikYtxiT+R3eb0N5U1hoDvaP=oevjWjUuAJ453p=@mail.gmail.com>
	<AANLkTinvz7b7yQ-MP4rZHudNuD-0A+Ag7ut0=ZNaCvyV@mail.gmail.com>
	<AANLkTiniPdzC4YEmq5_kJwv94fGmjE65i=Cjmd9VDMg5@mail.gmail.com>
Message-ID: <20101107194345.GD2862@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 01:35:26AM +0200, Zimny Lech wrote:
> 2010/10/22 Zimny Lech <napohybelskurwysynom2010@gmail.com>:
> > 2010/10/21 Zimny Lech <napohybelskurwysynom2010@gmail.com>:
> >> Ok, I dropped this patch. Recreated tree can be found here
> >> git pull git://github.com/napohybelskurwysynom2010/Linux-2.6-nps.git rodc2
> >
> > Sorry, I had to change the username, because some jerk denunciated me
> > on github ;)
> > git pull git://github.com/zimnylech/Linux-2.6-nps.git rodc2
> 
> Ping?

I'm not taking it as a git pull as it seems to contain changes outside
of ARM.  I think you need to split your patch up, and post it to relevant
lists as a series of patches, also making sure that you copy the relevant
people.
