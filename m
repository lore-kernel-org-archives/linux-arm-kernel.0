From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Oct 2010 11:27:06 +0200
Subject: [RFC] Removal of dead code from arch/arm/*
In-Reply-To: <AANLkTi=Cpq2_vV2RGcoQhrqk8xpL59AvLFPzfvTBk5Xa@mail.gmail.com>
References: <AANLkTim+vj_OAd22TdThuC-HSqUiDjguOHQWjyqFaq6N@mail.gmail.com>
	<AANLkTi=Cpq2_vV2RGcoQhrqk8xpL59AvLFPzfvTBk5Xa@mail.gmail.com>
Message-ID: <20101021092706.GI19834@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 08:32:06AM +0800, Eric Miao wrote:
> On Thu, Oct 21, 2010 at 8:23 AM, Zimny Lech
> <napohybelskurwysynom2010@gmail.com> wrote:
> > Hi,
> >
> > I will begin testing this, I would like to know your opinion about this patches
> > git pull git://github.com/napohybelskurwysynom2010/Linux-2.6-nps.git rodc1
> 
> Would be great if you can post the patches instead of letting people
> figuring out
> how to peek into your changes? (although a combination of "git remote add" +
> "git fetch" + "git log <your remote branch>" can do the trick, not that straight
> forward)
<gitlesson>

Actually the easiest and AFAICT most unintrusive way to get this branch
is:

	~/linux-2.6$ git fetch git://github.com/napohybelskurwysynom2010/Linux-2.6-nps.git rodc1
	....

	~/linux-2.6$ gitk origin/master..FETCH_HEAD

This doesn't even create a branch and the objects are subject to garbage
collection after the next fetch (i.e. when they aren't referenced by
FETCH_HEAD anymore).

And (as a small side note) you can combine git remote add + git fetch by
passing -f to git remote add.

</gitlesson>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
