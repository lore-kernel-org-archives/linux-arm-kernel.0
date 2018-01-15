From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 15 Jan 2018 23:22:42 +0000
Subject: PM regression in next
In-Reply-To: <20180115165050.GJ4821@atomide.com>
References: <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
Message-ID: <871siqbte4.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Tony

> > I'm sorry that my patch breaks your drivers.
> > It seems removing .read/.write callback was too much aggressive.
> 
> No problem, things happen. The thing I'm worried about here
> though is that these patches were "completely untested
> clean-up patches" :)

Yes, you are 100% true

> For the next set of changes like this,
> please make sure you Cc the driver authors so they can test
> and ack the changes if you can't test them, OK?

Actually, I have posted "convert codec/platform to component"
patch-set to ALSA ML, without Cc:ing to you.

	Subject: [PATCH 00/38] ASoC: replace platform to component
	Date: Fri, 12 Jan 2018 09:40:29 +0900

	Subject: [PATCH 000/187] ASoC: replace codec to component
	Date: Fri, 12 Jan 2018 10:05:05 +0900

I will send test request mail to each driver's authoer

Best regards
---
Kuninori Morimoto
