From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 22 Jun 2010 13:19:02 +0200
Subject: [PATCH] pxa3xx: Fix HSIO bus x24 multiplier
In-Reply-To: <201006221006.20590.pieterg@gmx.com>
References: <1277154123-31532-1-git-send-email-marek.vasut@gmail.com>
	<201006221006.20590.pieterg@gmx.com>
Message-ID: <201006221319.02992.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 22. ?ervna 2010 10:06:20 pieterg napsal(a):
> On Monday 21 June 2010 23:02:03 Marek Vasut wrote:
> > The value should be 24, not 0 in the possibilities array. It was just a
> > silly mistake.
> 
> Good one, reminds me that I've had this one on my list as well for a while.
> I actually went one step further, made the pxa310 use HSIO 312MHz when
> running on 624MHz.
> 
> (not sure whether the patch will apply cleanly, but cpufreq-pxa3xx.c still
> looks roughly the same at first glance..)
> 
> Rgds, Pieter

Hi,

I'd suggest you to submit a proper patch. With your whole name and using git-
send-email.

Cheers
