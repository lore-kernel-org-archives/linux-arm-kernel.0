From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Dec 2010 12:24:43 -0800
Subject: [REPOST][PATCH] Fix IGEPv2 second MMC channel power supply
In-Reply-To: <AANLkTi=9+AafKvyBanYeFjQtWQvUKK1rLLLJRO0z1ekw@mail.gmail.com>
References: <1291466438-12827-1-git-send-email-maz@misterjones.org>
	<AANLkTi=9+AafKvyBanYeFjQtWQvUKK1rLLLJRO0z1ekw@mail.gmail.com>
Message-ID: <20101213202443.GB3054@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletb? i Serra <eballetbo@gmail.com> [101213 08:47]:
> 
> Tony, please can this patch be included before 2.6.37 ? Without this
> patch the wifi module on IGEP v2 board not works.

Sorry it's too much for the -rc series. For the -rc series
the fixes should be major bugs. This is in the category
"it never worked before".

I will add it to omap-boards branch for the next merge window
over the next few days while going through all the pending
patches in patchwork.

Cheers,

Tony
