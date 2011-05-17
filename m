From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 May 2011 10:53:46 +0300
Subject: [RESEND PATCH 1/4] omap: igep0020: name refactoring for future
	merge with IGEP3
In-Reply-To: <BANLkTikJaN=Q2RgrA7Hz-ye2BCOjNK42zA@mail.gmail.com>
References: <cover.1305235542.git.mike@compulab.co.il>
	<d6dc9e334c729523f25993b7d610808e537ca74c.1305235542.git.mike@compulab.co.il>
	<BANLkTikJaN=Q2RgrA7Hz-ye2BCOjNK42zA@mail.gmail.com>
Message-ID: <20110517075345.GQ5323@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletb? i Serra <eballetbo@gmail.com> [110516 10:11]:
> Hi Mike,
> 
> The only comment I wanted to do is maybe I prefer rename the
> board-igep0020 to board-igep00x0 to be more generic. Apart from this
> these patch series looks good for me and has my ack. Thanks.

I suggest we do the rename separately later on. Otherwise it
easily gets classified as "crazy churn" type of patch, so best
to stick to just code coalescing and fixes for this merge window.

Tony
